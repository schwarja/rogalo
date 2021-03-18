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
                var result = [CharacteristicStoring]()
                
                if let temperature = device.temperatureEngine {
                    result.append(
                        CharacteristicStore(
                            value: .temperatureEngine(value: temperature),
                            range: device.engineTemperatureRange
                        )
                    )
                }
                if let temperature = device.temperatureExhaust {
                    result.append(
                        CharacteristicStore(
                            value: .temperatureExhaust(value: temperature),
                            range: device.exhaustTemperatureRange
                        )
                    )
                }
                if let rpm = device.rpm {
                    result.append(
                        CharacteristicStore(
                            value: .rpm(value: rpm),
                            range: device.rpmRange
                        )
                    )
                }
                if let voltage = device.voltage {
                    result.append(
                        CharacteristicStore(
                            value: .voltage(value: voltage),
                            range: device.batteryRange
                        )
                    )
                }
                if let time = device.flightTime {
                    result.append(CharacteristicStore(value: .flightTime(value: time)))
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
