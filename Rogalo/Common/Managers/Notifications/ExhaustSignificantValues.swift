//
//  ExhaustSignificantValues.swift
//  Rogalo
//
//  Created by Jan on 18.03.2021.
//

import Foundation

enum ExhaustSignificantValues: Double, CaseIterable, ResourceSpecifying {
    case emergency = 600
    
    static var sortedValues: [Self] {
        Self.allCases.sorted(by: { $0.rawValue >= $1.rawValue })
    }
    
    var resourceName: String {
        switch self {
        case .emergency:
            return "ExhaustCritical-600"
        }
    }
    
    var extensionName: String {
        "m4a"
    }
}
