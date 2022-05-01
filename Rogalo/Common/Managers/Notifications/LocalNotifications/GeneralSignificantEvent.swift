//
//  GeneralSignificantEvent.swift
//  Rogalo
//
//  Created by Jan Schwarz on 19.04.2022.
//

import Foundation

enum GeneralSignificantEvents {
    case notCharging
    case outOfFuel
}

extension GeneralSignificantEvents: TitleSpecifying {
    var title: String {
        switch self {
        case .notCharging:
            return LocalizedString.generalNotificationNotCharging()
        case .outOfFuel:
            return LocalizedString.generalNotificationNoFuel()
        }
    }
}

extension GeneralSignificantEvents: ResourceSpecifying {
    var resourceName: String {
        switch self {
        case .notCharging:
            return "battery_not_charge"
        case .outOfFuel:
            return "running_out_of_fuel"
        }
    }
    
    var extensionName: String {
        "mp3"
    }
}
