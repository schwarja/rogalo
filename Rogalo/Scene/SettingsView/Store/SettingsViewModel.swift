//
//  SettingsViewModel.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import Foundation

struct SettingsViewModel {
    let deviceName: String
    let deviceState: DeviceState
    let notificationsAutorization: NotificationAuthorizationStatus
    var rpmMultiplier: String
    let rpmMultipliers: [String]

    static let empty = SettingsViewModel(
        deviceName: "Name",
        deviceState: .connected,
        notificationsAutorization: .initial,
        rpmMultiplier: "1:1",
        rpmMultipliers: ["1:1", "1:2"]
    )
}
