//
//  TemperatureSignificantValues.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

enum EngineTemperatureSignificantEvents: Double, CaseIterable {
    case normal = -256
    case risk = 180
    case highRisk = 190
    case emergency = 200
    
    static var sortedValues: [Self] {
        Self.allCases.sorted(by: { $0.rawValue >= $1.rawValue })
    }
}

extension EngineTemperatureSignificantEvents: TitleSpecifying {
    var title: String {
        switch self {
        case .normal:
            return LocalizedString.generalNotificationTemperatureEngineOk()
        case .risk, .highRisk, .emergency:
            let formTemperature = Formatters.formattedTemperature(for: rawValue)

            return "\(LocalizedString.generalNotificationTemperatureEngineTitle()): \(LocalizedString.generalNotificationTemperatureSubtitle()) \(formTemperature)"
        }
    }
}
 
extension EngineTemperatureSignificantEvents: ResourceSpecifying {
    var resourceName: String {
        switch self {
        case .normal:
            return "engine_temp_is_ok"
        case .risk:
            return "TemperatureRisk-180"
        case .highRisk:
            return "TemperatureHighRist-185"
        case .emergency:
            return "TemperatureCritical-190"
        }
    }
    
    var extensionName: String {
        "m4a"
    }
}
