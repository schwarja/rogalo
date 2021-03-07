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
    
    var rpmMultiplier: String {
        let value = settingsService.rpmMultiplier.value

        guard let index = settingsService.rpmMultipliers.firstIndex(of: value) else {
            return ""
        }
        return rpmMultipliers[index]
    }
    lazy var rpmMultipliers: [String] = {
        settingsService
            .rpmMultipliers
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
                    rpmMultiplier: self.rpmMultiplier,
                    rpmMultipliers: self.rpmMultipliers
                )
            }
            .eraseToAnyPublisher()
    }

    init(deviceManager: DeviceManaging, notificationsManager: NotificationManaging, settingsService: SettingsServicing) {
        self.deviceManager = deviceManager
        self.notificationsManager = notificationsManager
        self.settingsService = settingsService
    }
    
    func didUpdate(rpmMultiplier: String) {
        guard let index = rpmMultipliers.firstIndex(of: rpmMultiplier) else {
            return
        }

        settingsService.rpmMultiplier.send(settingsService.rpmMultipliers[index])
    }
}
