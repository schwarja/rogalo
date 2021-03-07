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
    
    let batteryTypes: [Battery.BatteryType] = [.lipo, .nicd]
    
    let batteryType: CurrentValueSubject<Battery.BatteryType, Never>
    
    private var cancellables = Set<AnyCancellable>()
    
    init(storage: Storage) {
        self.storage = storage
        
        self.batteryType = CurrentValueSubject(storage.battery.value.type)
        
        self.batteryType
            .removeDuplicates()
            .sink { batteryType in
                storage.battery.value = Battery(type: batteryType)
            }
            .store(in: &cancellables)
        
        storage.battery
            .removeDuplicates()
            .sink { [weak self] battery in
                self?.batteryType.value = battery.type
            }
            .store(in: &cancellables)
    }
}
