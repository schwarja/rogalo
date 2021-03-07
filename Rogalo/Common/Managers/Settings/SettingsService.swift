//
//  RevolutionsManager.swift
//  Rogalo
//
//  Created by Jan on 07.03.2021.
//

import Combine

class SettingsService: SettingsServicing {
    private let storage: Storage
    
    let revolutionsMultipliers: [Float] = [1, 2]
    
    var revolutionsMultiplier: CurrentValueSubject<Float, Never> {
        storage.revolutionsMultiplier
    }
    
    init(storage: Storage) {
        self.storage = storage
    }
}
