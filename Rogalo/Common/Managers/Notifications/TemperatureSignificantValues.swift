//
//  TemperatureSignificantValues.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

enum TemperatureSignificantValues: Double, CaseIterable, ResourceSpecifying {
    case risk = 180
    case highRisk = 185
    case emergency = 190
    
    static var sortedValues: [Self] {
        Self.allCases.sorted(by: { $0.rawValue >= $1.rawValue })
    }
    
    var resourceName: String {
        switch self {
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
