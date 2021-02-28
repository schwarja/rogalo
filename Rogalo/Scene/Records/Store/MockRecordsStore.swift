//
//  MockRecordsStore.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Combine

class MockRecordsStore: RecordsStoring {
    var connectionState: AnyPublisher<Device.State, Never> {
        Just<Device.State>(.connecting)
            .eraseToAnyPublisher()
    }
    
    var characteristics: AnyPublisher<[CharacteristicStoring], Never> {
        Just<[CharacteristicStoring]>([
                CharacteristicStore(value: .rpmMax(value: 8000))
            ])
            .eraseToAnyPublisher()
    }
}
