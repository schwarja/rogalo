//
//  MockPairingStore.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

class MockPairingStore: PairingStoring {
    var model: AnyPublisher<PeripheralListViewModel, Never> {
        Just(PeripheralListViewModel.empty)
            .eraseToAnyPublisher()
    }
}
