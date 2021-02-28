//
//  RecordsStore.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Combine
import Foundation

class RecordsStore: RecordsStoring {
    var connectionState: AnyPublisher<Device.State, Never> {
        deviceManager
            .device
            .map(\.state)
            .eraseToAnyPublisher()
    }
    var characteristics: AnyPublisher<[CharacteristicStoring], Never> {
        deviceManager
            .device.map { device -> [CharacteristicStoring] in
                [
                    CharacteristicStore(value: .temperatureMax(value: device.temperatureMax)),
                    CharacteristicStore(value: .rpmMax(value: device.rpmMax)),
                    CharacteristicStore(value: .motoTime(value: device.motoTime))
                ]
            }
            .eraseToAnyPublisher()
    }

    let deviceManager: DeviceManaging
    
    init(deviceManager: DeviceManaging) {
        self.deviceManager = deviceManager
    }
}
