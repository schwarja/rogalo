//
//  ConnectivitySignificantEvents.swift
//  Rogalo
//
//  Created by Jan Schwarz on 19.04.2022.
//

import Foundation

enum ConnectivitySignificantEvents {
    case connected
    case disconnected
}

extension ConnectivitySignificantEvents: TitleSpecifying {
    var title: String {
        switch self {
        case .connected:
            return LocalizedString.generalNotificationConnectivityConnected()
        case .disconnected:
            return LocalizedString.generalNotificationConnectivityDisconnected()
        }
    }
}

extension ConnectivitySignificantEvents: ResourceSpecifying {
    var resourceName: String {
        switch self {
        case .connected:
            return "connected"
        case .disconnected:
            return "disconnected"
        }
    }
    
    var extensionName: String {
        "m4a"
    }
}
