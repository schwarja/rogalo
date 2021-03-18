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
    private let player = AVPlayer()
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
        case let .temperatureAlert(type):
            content = notificationContent(for: type)
        case let .exhaustAlert(type):
            content = notificationContent(for: type)
        }
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)

        UNUserNotificationCenter.current().add(request)
    }
    
    func notificationContent(for temperature: TemperatureSignificantValues) -> UNMutableNotificationContent {
        let temperatureRaw = temperature.rawValue
        let formTemperature = Formatters.formattedTemperature(for: temperatureRaw)
        
        let content = UNMutableNotificationContent()
        content.title = "\(LocalizedString.generalNotificationTemperatureEngineTitle()): \(LocalizedString.generalNotificationTemperatureSubtitle()) \(formTemperature)"
        content.sound = UNNotificationSound
            .criticalSoundNamed(UNNotificationSoundName(temperature.fileName))
        
        return content
    }
    
    func notificationContent(for temperature: ExhaustSignificantValues) -> UNMutableNotificationContent {
        let temperatureRaw = temperature.rawValue
        let formTemperature = Formatters.formattedTemperature(for: temperatureRaw)
        
        let content = UNMutableNotificationContent()
        content.title = "\(LocalizedString.generalNotificationTemperatureExhaustTitle()): \(LocalizedString.generalNotificationTemperatureSubtitle()) \(formTemperature)"
        content.sound = UNNotificationSound
            .criticalSoundNamed(UNNotificationSoundName(temperature.fileName))
        
        return content
    }
}

// MARK: - Audio notifications
private extension NotificationManager {
    func playNotification(for event: NotificationEvent) {
        let item: AVPlayerItem?
        switch event {
        case let .temperatureAlert(type):
            item = notificationPlayerItem(for: type)
        case let .exhaustAlert(type):
            item = notificationPlayerItem(for: type)
        }

        player.replaceCurrentItem(with: item)
        player.play()
        
        generator.notificationOccurred(.warning)
    }
    
    func notificationPlayerItem(for resource: ResourceSpecifying) -> AVPlayerItem? {
        guard let url = Bundle.main.url(
            forResource: resource.resourceName,
            withExtension: resource.extensionName
        ) else {
            return nil
        }
        
        return AVPlayerItem(url: url)
    }
}
