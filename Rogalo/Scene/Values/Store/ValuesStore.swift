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
    var characteristics: AnyPublisher<[DeviceValueStoring], Never> {
        deviceManager
            .device
            .map { device -> [DeviceValueStoring] in
                var result = [DeviceValueStoring]()
                
                if let temperature = device.temperatureEngine {
                    result.append(
                        DeviceValueStore(
                            value: .temperatureEngine(value: temperature),
                            range: device.engineTemperatureRange
                        )
                    )
                }
                if let temperature = device.temperatureExhaust {
                    result.append(
                        DeviceValueStore(
                            value: .temperatureExhaust(value: temperature),
                            range: device.exhaustTemperatureRange
                        )
                    )
                }
                if let rpm = device.rpm {
                    result.append(
                        DeviceValueStore(
                            value: .rpm(value: rpm),
                            range: device.rpmRange
                        )
                    )
                }
                if let voltage = device.voltage {
                    result.append(
                        DeviceValueStore(
                            value: .voltage(value: voltage),
                            range: device.batteryRange
                        )
                    )
                }
                if let time = device.flightTime {
                    result.append(DeviceValueStore(value: .flightTime(value: time)))
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
