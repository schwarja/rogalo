//
//  MockEngineStore.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

class MockValuesStore: ValuesStoring {
    var connectionState: AnyPublisher<DeviceState, Never> {
        Just<DeviceState>(.connecting)
            .eraseToAnyPublisher()
    }
    
    var characteristics: AnyPublisher<[CharacteristicStoring], Never> {
        Just<[CharacteristicStoring]>([
                CharacteristicStore(value: .rpm(value: 8000))
            ])
            .eraseToAnyPublisher()
    }
}
