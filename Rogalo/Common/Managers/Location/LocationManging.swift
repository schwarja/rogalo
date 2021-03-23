//
//  LocationManging.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Combine

protocol LocationManaging: AnyObject {
    var location: AnyPublisher<Location, Never> { get }
    var error: AnyPublisher<Error, Never> { get }
    var authorization: AnyPublisher<LocationAuthorization, Never> { get }

    func requestAuthorization()
    func refreshLocation()
}
