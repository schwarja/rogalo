//
//  SettingsViewStore.swift
//  Rogalo
//
//  Created by Jan on 07.03.2021.
//

import Combine
import SwiftUI

class SettingsViewStore: SettingsViewStoring {
    let deviceManager: DeviceManaging
    let notificationsManager: NotificationManaging
    let settingsService: SettingsServicing
    
    var revolutionsMultiplier: String {
        let value = settingsService.revolutionsMultiplier.value

        guard let index = settingsService.revolutionsMultipliers.firstIndex(of: value) else {
            return ""
        }
        return revolutionsMultipliers[index]
    }
    lazy var revolutionsMultipliers: [String] = {
        settingsService
            .revolutionsMultipliers
            .map { value -> String in
                let stringValue = String(format: "%.f", value)
                return "1 : \(stringValue)"
            }
    }()

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
                    notificationsAutorization: notificationAuthorizationStatus,
                    revolutionsMultiplier: self.revolutionsMultiplier,
                    revolutionsMultipliers: self.revolutionsMultipliers
                )
            }
            .eraseToAnyPublisher()
    }

    init(deviceManager: DeviceManaging, notificationsManager: NotificationManaging, settingsService: SettingsServicing) {
        self.deviceManager = deviceManager
        self.notificationsManager = notificationsManager
        self.settingsService = settingsService
    }
    
    func didUpdate(revolutionsMultiplier: String) {
        guard let index = revolutionsMultipliers.firstIndex(of: revolutionsMultiplier) else {
            return
        }

        settingsService.revolutionsMultiplier.send(settingsService.revolutionsMultipliers[index])
    }
}
