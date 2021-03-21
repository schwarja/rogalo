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
    var characteristics: AnyPublisher<[DeviceValueStoring], Never> {
        deviceManager
            .device.map { device -> [DeviceValueStoring] in
                var result = [DeviceValueStoring]()
                
                if let temperature = device.temperatureEngineMax {
                    result.append(DeviceValueStore(value: .temperatureEngineMax(value: temperature)))
                }
                if let temperature = device.temperatureExhaustMax {
                    result.append(DeviceValueStore(value: .temperatureExhaustMax(value: temperature)))
                }
                if let rpm = device.rpmMax {
                    result.append(DeviceValueStore(value: .rpmMax(value: rpm)))
                }
                if let time = device.motoTime {
                    result.append(DeviceValueStore(value: .motoTime(value: time)))
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
