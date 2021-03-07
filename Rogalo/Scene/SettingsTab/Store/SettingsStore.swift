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
    let settingsService: SettingsServicing

    var settingsViewStore: SettingsViewStoring {
        SettingsViewStore(deviceManager: deviceManager, notificationsManager: notificationsManager, settingsService: settingsService)
    }

    init(deviceManager: DeviceManaging, notificationsManager: NotificationManaging, settingsService: SettingsServicing) {
        self.deviceManager = deviceManager
        self.notificationsManager = notificationsManager
        self.settingsService = settingsService
    }
}
