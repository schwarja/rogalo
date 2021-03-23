//
//  MockRecordsStore.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Combine

class MockRecordsStore: RecordsStoring {
    var connectionState: AnyPublisher<DeviceState, Never> {
        Just<DeviceState>(.connecting)
            .eraseToAnyPublisher()
    }
    
    var characteristics: AnyPublisher<[DeviceValueStoring], Never> {
        Just<[DeviceValueStoring]>([
                DeviceValueStore(value: .rpmMax(value: 8000))
            ])
            .eraseToAnyPublisher()
    }
}
