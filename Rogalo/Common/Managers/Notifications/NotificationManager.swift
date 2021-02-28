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
    private var authorizationStatusSubject = PassthroughSubject<NotificationAuthorizationStatus, Never>()
    
    var authorizationStatus: AnyPublisher<NotificationAuthorizationStatus, Never> {
        authorizationStatusSubject.eraseToAnyPublisher()
    }
    
    init() {
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
    }
    
    @objc func sceneWillDeactivate() {
        isSceneActive = false
    }
}

// MARK: - Push notifications
private extension NotificationManager {
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
        }
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)

        UNUserNotificationCenter.current().add(request)
    }
    
    func notificationContent(for temperature: TemperatureSignificantValues) -> UNMutableNotificationContent {
        let temperatureRaw = temperature.rawValue
        let formTemperature = Formatters.formattedTemperature(for: temperatureRaw)
        
        let content = UNMutableNotificationContent()
        content.title = "Tempareture alert: Temperature at \(formTemperature)"
        content.sound = UNNotificationSound
            .criticalSoundNamed(UNNotificationSoundName(temperature.notificationSoundFileName))
        
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
        }

        player.replaceCurrentItem(with: item)
        player.play()
        
        generator.notificationOccurred(.warning)
    }
    
    func notificationPlayerItem(for temperature: TemperatureSignificantValues) -> AVPlayerItem? {
        guard let url = Bundle.main.url(
            forResource: temperature.notificationSoundResourceName,
            withExtension: temperature.notificationSoundExtensionName
        ) else {
            return nil
        }
        
        return AVPlayerItem(url: url)
    }
}
