//
//  MockMapStore.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Combine

class MockMapStore: MapStoring {
    var authorization: AnyPublisher<LocationAuthorization, Never> {
        Just(.authorized)
            .eraseToAnyPublisher()
    }
    
    var location: AnyPublisher<Location, Never> {
        Just(
            Location(latitude: 50, longitude: 15, speed: 10, altitude: 250)
        )
        .eraseToAnyPublisher()
    }
}
