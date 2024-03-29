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
    
    var currentLocation: AnyPublisher<Location, Never> {
        Just(
            Location(latitude: 50, longitude: 15, speed: 10, altitude: 250, course: 0)
        )
        .eraseToAnyPublisher()
    }
    
    var locations: AnyPublisher<[Location], Never> {
        Just(
            [Location]()
        )
        .eraseToAnyPublisher()
    }
}
