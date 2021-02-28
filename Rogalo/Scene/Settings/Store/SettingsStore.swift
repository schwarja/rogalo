//
//  SettingsStore.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

class SettingsStore: SettingsStoring {
    let deviceManager: DeviceManaging
    let notificationsManager: NotificationManaging
    
    var model: AnyPublisher<SettingsViewModel, Never> {
        let authorization = notificationsManager
            .authorizationStatus
            .compactMap { $0 }
        
        return Publishers
            .CombineLatest(deviceManager.device, authorization)
            .map { device, notificationAuthorizationStatus in
                SettingsViewModel(
                    deviceName: device.name,
                    deviceState: device.state,
                    notificationsAutorization: notificationAuthorizationStatus
                )
            }
            .eraseToAnyPublisher()
    }
    
    init(deviceManager: DeviceManaging, notificationsManager: NotificationManaging) {
        self.deviceManager = deviceManager
        self.notificationsManager = notificationsManager
    }
}
