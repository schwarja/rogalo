//
//  RecordsStore.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Combine
import Foundation

class RecordsStore: RecordsStoring {
    var connectionState: AnyPublisher<DeviceState, Never> {
        deviceManager
            .device
            .map(\.state)
            .eraseToAnyPublisher()
    }
    var characteristics: AnyPublisher<[CharacteristicStoring], Never> {
        deviceManager
            .device.map { device -> [CharacteristicStoring] in
                var result = [CharacteristicStoring]()
                
                if let temperature = device.temperatureEngineMax {
                    result.append(CharacteristicStore(value: .temperatureEngineMax(value: temperature)))
                }
                if let temperature = device.temperatureExhaustMax {
                    result.append(CharacteristicStore(value: .temperatureExhaustMax(value: temperature)))
                }
                if let rpm = device.rpmMax {
                    result.append(CharacteristicStore(value: .rpmMax(value: rpm)))
                }
                if let time = device.motoTime {
                    result.append(CharacteristicStore(value: .motoTime(value: time)))
                }
                
                return result
            }
            .eraseToAnyPublisher()
    }

    let deviceManager: DeviceManaging
    
    init(deviceManager: DeviceManaging) {
        self.deviceManager = deviceManager
    }
}
