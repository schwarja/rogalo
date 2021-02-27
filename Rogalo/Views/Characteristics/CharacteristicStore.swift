//
//  CharacteristicStore.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

struct CharacteristicStore: CharacteristicStoring {
    let value: DeviceValue
    
    var formattedValue: String {
        value.formattedString
    }
    
    var valueDescription: String {
        value.description
    }
    
    init(value: DeviceValue) {
        self.value = value
    }
}
