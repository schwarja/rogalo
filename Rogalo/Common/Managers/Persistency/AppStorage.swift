//
//  AppStorage.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine
import Foundation

class AppStorage: Storage {
    enum UserDefaultsKey: String, CaseIterable {
        case peripheral
        case revolutionsMultiplier
    }
    
    private let container: UserDefaults
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private var cancellables = Set<AnyCancellable>()
    
    let pairedDevice = CurrentValueSubject<Peripheral?, Never>(nil)
    let revolutionsMultiplier = CurrentValueSubject<Float, Never>(1)
    
    init(container: UserDefaults) {
        self.container = container
        
        setup()
    }
}

// MARK: Setup
private extension AppStorage {
    func setup() {
        for key in UserDefaultsKey.allCases {
            switch key {
            case .peripheral:
                setupEncodableObject(for: .peripheral, type: Peripheral.self, subject: pairedDevice)
            case .revolutionsMultiplier:
                setupFloat(for: .revolutionsMultiplier, subject: revolutionsMultiplier)
            }
        }
    }
    
    func setupEncodableObject<T: Codable>(for key: UserDefaultsKey, type: T.Type, subject: CurrentValueSubject<T?, Never>) {
        if
            let rawData = data(for: key),
            let object = try? decoder.decode(type, from: rawData)
        {
            subject.value = object
        }
        
        subject
            .map { [weak self] object in
                do {
                    return try self?.encoder.encode(object)
                } catch {
                    return nil
                }
            }
            .sink { [weak self] data in
                self?.store(data, for: key)
            }
            .store(in: &cancellables)
    }
    
    func setupFloat(for key: UserDefaultsKey, subject: CurrentValueSubject<Float, Never>) {
        if let value = float(for: key) {
            subject.value = value
        }
        
        subject
            .sink { [weak self] value in
                self?.store(value, for: key)
            }
            .store(in: &cancellables)
    }
}
 
// MARK: Getters/Setters
private extension AppStorage {
    func decode<T: Decodable>(for key: UserDefaultsKey) -> T? {
        guard
            let rawData = data(for: key),
            let object = try? decoder.decode(T.self, from: rawData)
        else
        {
            return nil
        }
        
        return object
    }
    
    func encode<T: Encodable>(_ object: T) -> Any? {
        do {
            return try encoder.encode(object)
        } catch {
            return nil
        }
    }
    
    func data(for key: UserDefaultsKey) -> Data? {
        container.data(forKey: key.rawValue)
    }
    
    func float(for key: UserDefaultsKey) -> Float? {
        container.object(forKey: key.rawValue) as? Float
    }
    
    func store(_ value: Any?, for key: UserDefaultsKey) {
        container.set(value, forKey: key.rawValue)
    }
}
