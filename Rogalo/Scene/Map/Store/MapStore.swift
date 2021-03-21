//
//  MapStore.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Combine

class MapStore: MapStoring {
    let locationManager: LocationManaging
    
    var location: AnyPublisher<Location, Never> {
        locationManager.location
    }
    var authorization: AnyPublisher<LocationAuthorization, Never> {
        locationManager
            .authorization
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] status in
                if status == .authorized || status == .authorizedNotPrecise {
                    self?.locationManager.refreshLocation()
                }
            })
            .eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(locationManager: LocationManaging) {
        self.locationManager = locationManager

        locationManager.requestAuthorization()
    }
}
