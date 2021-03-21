//
//  MapStoring.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Combine

protocol MapStoring {
    var authorization: AnyPublisher<LocationAuthorization, Never> { get }
    var location: AnyPublisher<Location, Never> { get }
}
