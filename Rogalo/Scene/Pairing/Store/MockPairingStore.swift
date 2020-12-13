//
//  MockPairingStore.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

class MockPairingStore: PairingStoring {
    let state = CurrentValueSubject<PairingStoreState, Never>(.initial)
    
    func didSelect(peripheral: Peripheral) {
        
    }
}
