//
//  PairingView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Combine

class PairingStore: PairingStoring {
    lazy var model: AnyPublisher<PeripheralListViewModel, Never> = modelPublisher
    
    let bluetoothManager: BluetoothManaging
    
    init(bluetoothManager: BluetoothManaging) {
        self.bluetoothManager = bluetoothManager
    }
}

private extension PairingStore {
    var modelPublisher: AnyPublisher<PeripheralListViewModel, Never> {
        Publishers
            .CombineLatest(bluetoothManager.status, bluetoothManager.peripherals)
            .map { status, peripherals -> PeripheralListViewModel in
                let state: DeviceState
                switch status {
                case .initial, .scanning:
                    state = .connecting
                case .notAvailable:
                    state = .failed(error: .bleTurnedOff)
                case .unauthorized:
                    state = .failed(error: .bleUnauthorized)
                }
                
                return PeripheralListViewModel(connectionState: state, peripherals: peripherals)
            }
            .share()
            .eraseToAnyPublisher()
    }
}
