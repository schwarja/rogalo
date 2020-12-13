//
//  AppStorage.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine
import Foundation

class AppStorage: Storage {
    enum UserDefaultsKey: String {
        case peripheral
    }
    
    private let container: UserDefaults
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private var cancellables = Set<AnyCancellable>()
    
    let pairedDevice = CurrentValueSubject<Peripheral?, Never>(nil)
    
    init(container: UserDefaults) {
        self.container = container
        
        setup()
    }
}

// MARK: Private methods
private extension AppStorage {
    func setup() {
        if
            let rawData = data(for: .peripheral),
            let device = try? decoder.decode(Peripheral.self, from: rawData)
        {
            pairedDevice.value = device
        }
        
        pairedDevice
            .map { [weak self] device in
                do {
                    return try self?.encoder.encode(device)
                } catch {
                    return nil
                }
            }
            .sink { [weak self] data in
                self?.store(data, for: .peripheral)
            }
            .store(in: &cancellables)
    }
    
    func data(for key: UserDefaultsKey) -> Data? {
        container.data(forKey: key.rawValue)
    }
    
    func store(_ data: Data?, for key: UserDefaultsKey) {
        container.set(data, forKey: key.rawValue)
    }
}
