//
//  SettingsService.swift
//  Rogalo
//
//  Created by Jan on 07.03.2021.
//

import Combine

class SettingsService: SettingsServicing {
    private let storage: Storage
    
    let rpmMultipliers: [Float] = [1, 2]
    
    var rpmMultiplier: CurrentValueSubject<Float, Never> {
        storage.rpmMultiplier
    }
    
    init(storage: Storage) {
        self.storage = storage
    }
}
