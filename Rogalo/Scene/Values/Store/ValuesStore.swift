//
//  EngineStore.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Combine

class ValuesStore: ValuesStoring {
    var connectionState: AnyPublisher<Device.State, Never> {
        deviceManager
            .device
            .map(\.state)
            .eraseToAnyPublisher()
    }
    var characteristics: AnyPublisher<[CharacteristicStoring], Never> {
        deviceManager
            .device
            .map { device -> [CharacteristicStoring] in
                [
                    CharacteristicStore(value: .temperature(value: device.temperature)),
                    CharacteristicStore(value: .rpm(value: device.rpm)),
                    CharacteristicStore(value: .voltage(value: device.voltage)),
                    CharacteristicStore(value: .flightTime(value: device.flightTime))
                ]
            }
            .eraseToAnyPublisher()
    }
    
    let deviceManager: DeviceManaging
    
    init(deviceManager: DeviceManaging) {
        self.deviceManager = deviceManager
    }
}
