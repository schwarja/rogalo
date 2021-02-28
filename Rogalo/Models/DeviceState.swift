//
//  DeviceState.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import Foundation

enum DeviceState: Equatable {
    case connecting
    case connected
    case failed(error: DeviceStateError)
}

enum DeviceStateError: LocalizedError, Equatable {
    case bleUnauthorized
    case bleTurnedOff
    case connectionIssues(String)
    
    var errorDescription: String? {
        switch self {
        case .bleTurnedOff:
            return LocalizedString.pairingBluetoothTurnedOff()
        case .bleUnauthorized:
            return LocalizedString.generalAlertBluetoothPermissionDeniedTitle()
        case .connectionIssues(let desc):
            return desc
        }
    }
    
    var resolutionDescription: String? {
        switch self {
        case .bleTurnedOff:
            return nil
        case .bleUnauthorized:
            return LocalizedString.generalAlertBluetoothPermissionDeniedSubtitle()
        case .connectionIssues:
            return nil
        }
    }
}
