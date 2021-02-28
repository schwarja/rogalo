//
//  PairingStoring.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

protocol PairingStoring {
    var model: AnyPublisher<PeripheralListViewModel, Never> { get }
}
