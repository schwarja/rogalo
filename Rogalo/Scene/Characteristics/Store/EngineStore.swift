//
//  EngineStore.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Combine

class EngineStore: ObservableObject {
    @Published var engine: Engine?
    
    let bluetoothManager: BluetoothManaging
    
    private var cancellables = Set<AnyCancellable>()
    
    init(bluetoothManager: BluetoothManaging) {
        self.bluetoothManager = bluetoothManager
        
        listenToEngine()
    }
}

private extension EngineStore {
    func listenToEngine() {
        bluetoothManager
            .engine
            .assign(to: \.engine, on: self)
            .store(in: &cancellables)
    }
}
