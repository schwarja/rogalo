//
//  CharacteristicStore.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import SwiftUI

struct CharacteristicStore: CharacteristicStoring {
    let value: DeviceValue
    
    var formattedValue: String {
        value.formattedString
    }
    
    var valueDescription: String {
        value.description
    }
    
    var scale: CharacteristicScale? {
        guard let risk = value.riskProgress, let progress = value.progress else {
            return nil
        }
        
        return CharacteristicScale(midLocation: CGFloat(risk), progress: CGFloat(progress))
    }
    
    init(value: DeviceValue) {
        self.value = value
    }
}
