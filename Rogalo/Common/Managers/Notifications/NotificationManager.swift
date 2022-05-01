//
//  NotificationManager.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import AVFoundation
import Combine
import UIKit
import UserNotifications

class NotificationManager: NotificationManaging {
    typealias Event = TitleSpecifying & ResourceSpecifying
    
    private let player = AVQueuePlayer()
    private let generator = UINotificationFeedbackGenerator()
    
    private var isSceneActive = true
    private var authorizationStatusSubject = CurrentValueSubject<NotificationAuthorizationStatus?, Never>(nil)
    
    var authorizationStatus: AnyPublisher<NotificationAuthorizationStatus?, Never> {
        authorizationStatusSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    init() {
        getAuthorizationStatus()
        requestAuthorization()
        registerForLifecycleEvents()
    }
    
    func sendNotification(for event: NotificationEvent) {
        if isSceneActive {
            playNotification(for: event)
        } else {
            sendPushNotification(for: event)
        }
    }
}

// MARK: - Life Cycle
private extension NotificationManager {
    func registerForLifecycleEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(sceneDidBecomeActive), name: UIScene.didActivateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sceneWillDeactivate), name: UIScene.willDeactivateNotification, object: nil)
    }
    
    @objc func sceneDidBecomeActive() {
        isSceneActive = true
        getAuthorizationStatus()
    }
    
    @objc func sceneWillDeactivate() {
        isSceneActive = false
    }
}

// MARK: - Push notifications
private extension NotificationManager {
    func getAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            switch settings.authorizationStatus {
            case .authorized:
                self?.authorizationStatusSubject.send(.authorized)
            case .notDetermined:
                self?.authorizationStatusSubject.send(.initial)
            default:
                self?.authorizationStatusSubject.send(.denied)
            }
        }
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { [weak self] (success, _) in
            let value = success ? NotificationAuthorizationStatus.authorized : NotificationAuthorizationStatus.denied
            self?.authorizationStatusSubject.send(value)
        }
    }
    
    func sendPushNotification(for event: NotificationEvent) {
        let content: UNMutableNotificationContent
        switch event {
        case .temperatureAlert(let type as Event),
                .exhaustAlert(let type as Event),
                .connectivityEvent(let type as Event),
                .general(let type as Event):
            content = notificationContent(for: type)
        }
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)

        UNUserNotificationCenter.current().add(request)
    }
    
    func notificationContent(for event: Event) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = event.title
        content.sound = UNNotificationSound
            .criticalSoundNamed(UNNotificationSoundName(event.fileName))
        
        return content
    }
}

// MARK: - Audio notifications
private extension NotificationManager {
    func playNotification(for event: NotificationEvent) {
        let item: AVPlayerItem?
        switch event {
        case .temperatureAlert(let type as ResourceSpecifying),
                .exhaustAlert(let type as ResourceSpecifying),
                .connectivityEvent(let type as ResourceSpecifying),
                .general(let type as ResourceSpecifying):
            item = notificationPlayerItem(for: type)
        }
        
        guard let item = item else {
            return
        }

        player.insert(item, after: player.items().last)
        player.play()
        
        generator.notificationOccurred(.warning)
    }
    
    func notificationPlayerItem(for resource: ResourceSpecifying) -> AVPlayerItem? {
        guard let url = Bundle.main.url(
            forResource: resource.localizedResourceName,
            withExtension: resource.extensionName
        ) else {
            return nil
        }
        
        return AVPlayerItem(url: url)
    }
}
