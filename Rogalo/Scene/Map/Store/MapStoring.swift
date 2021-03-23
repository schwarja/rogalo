//
//  MapStoring.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Combine

protocol MapStoring {
    var authorization: AnyPublisher<LocationAuthorization, Never> { get }
    var currentLocation: AnyPublisher<Location, Never> { get }
    var locations: AnyPublisher<[Location], Never> { get }
}
