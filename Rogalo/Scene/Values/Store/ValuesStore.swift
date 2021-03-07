//
//  EngineStore.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Combine

class ValuesStore: ValuesStoring {
    var connectionState: AnyPublisher<DeviceState, Never> {
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
                    CharacteristicStore(value: .temperature(value: device.temperature), range: device.temperatureRange),
                    CharacteristicStore(value: .rpm(value: device.rpm), range: device.rpmRange),
                    CharacteristicStore(value: .voltage(value: device.voltage), range: device.batteryRange),
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
