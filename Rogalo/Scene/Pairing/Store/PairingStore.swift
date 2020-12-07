//
//  PairingView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Combine

class PairingStore: ObservableObject {
    @Published var state: PairingStoreState = .initial
    
    let bluetoothManager: BluetoothManaging
    
    private var cancellables = Set<AnyCancellable>()
    
    init(bluetoothManager: BluetoothManaging) {
        self.bluetoothManager = bluetoothManager
        
        state = .loading
        
        listenToPeripherals()
    }
    
    func pair(peripheral: Peripheral) {
        bluetoothManager.pair(peripheral: peripheral)
    }
}

private extension PairingStore {
    func listenToPeripherals() {
        bluetoothManager
            .peripherals
            .sink { [weak self] peripherals in
                self?.state = .ready(data: peripherals)
            }
            .store(in: &cancellables)
    }
}
