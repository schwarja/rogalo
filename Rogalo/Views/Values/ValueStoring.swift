//
//  CharacteristicStoring.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

protocol ValueStoring {
    var value: Value { get }
    var formattedValue: String { get }
    var valueDescription: String { get }
    
    var scale: ValueScale? { get }
}

extension ValueStoring {
    var formattedValue: String {
        value.formattedString
    }
    
    var valueDescription: String {
        value.description
    }
}
