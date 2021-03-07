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
    var revolutionsMultiplier: String
    let revolutionsMultipliers: [String]

    static let empty = SettingsViewModel(
        deviceName: "Name",
        deviceState: .connected,
        notificationsAutorization: .initial,
        revolutionsMultiplier: "1:1",
        revolutionsMultipliers: ["1:1", "1:2"]
    )
}
