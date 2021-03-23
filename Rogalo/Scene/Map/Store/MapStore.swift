//
//  MapStore.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Combine

class MapStore: MapStoring {
    let locationManager: LocationManaging
    
    lazy var authorization: AnyPublisher<LocationAuthorization, Never> = {
        locationManager
            .authorization
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] status in
                if status == .authorized || status == .authorizedNotPrecise {
                    self?.locationManager.refreshLocation()
                }
            })
            .eraseToAnyPublisher()
    }()
    lazy var currentLocation: AnyPublisher<Location, Never> = {
        locationManager.location
    }()
    lazy var locations: AnyPublisher<[Location], Never> = {
        currentLocation
            .scan([Location]()) { (previous, new) -> [Location] in
                previous + [new]
            }
            .share()
            .eraseToAnyPublisher()
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(locationManager: LocationManaging) {
        self.locationManager = locationManager
        
        locationManager.requestAuthorization()
    }
}
