//
//  PairingView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Combine

class PairingStore: PairingStoring {
    let state = CurrentValueSubject<PairingStoreState, Never>(.initial)
    
    let bluetoothManager: BluetoothManaging
    let storage: Storage
    
    private var cancellables = Set<AnyCancellable>()
    
    init(bluetoothManager: BluetoothManaging, storage: Storage) {
        self.bluetoothManager = bluetoothManager
        self.storage = storage
        
        state.value = .loading
        
        listenToPeripherals()
    }
    
    func didSelect(peripheral: Peripheral) {
        storage.pairedDevice.value = peripheral
    }
}

private extension PairingStore {
    func listenToPeripherals() {
        bluetoothManager
            .status
            .filter { $0 == .scanning }
            .flatMap { [weak self] _ -> AnyPublisher<[Peripheral], Never> in
                guard let self = self else {
                    return Empty<[Peripheral], Never>().eraseToAnyPublisher()
                }
                
                return self.bluetoothManager.peripherals
            }
            .sink { [weak self] peripherals in
                if peripherals.isEmpty {
                    self?.state.value = .loading
                } else {
                    self?.state.value = .ready(data: peripherals)
                }
            }
            .store(in: &cancellables)

        bluetoothManager
            .status
            .filter { $0 != .scanning }
            .sink { [weak self] status in
                switch status {
                case .initial:
                    self?.state.value = .loading
                case .notAvailable:
                    self?.state.value = .notAvailable
                case .unauthorized:
                    self?.state.value = .unauthorized
                case .scanning:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
