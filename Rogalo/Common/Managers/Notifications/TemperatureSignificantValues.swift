//
//  TemperatureSignificantValues.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

enum TemperatureSignificantValues: Double, CaseIterable {
    case risk = 180
    case highRisk = 185
    case emergency = 190
    
    static var sortedValues: [Self] {
        Self.allCases.sorted(by: { $0.rawValue >= $1.rawValue })
    }
    
    var notificationSoundResourceName: String {
        switch self {
        case .risk:
            return "180"
        case .highRisk:
            return "185"
        case .emergency:
            return "190"
        }
    }
    
    var notificationSoundExtensionName: String {
        "m4a"
    }
    
    var notificationSoundFileName: String {
        "\(notificationSoundResourceName).\(notificationSoundExtensionName)"
    }
}
