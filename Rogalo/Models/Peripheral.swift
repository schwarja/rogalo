//
//  Peripheral.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import CoreBluetooth

struct Peripheral: Codable {
    private enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    let id: String
    let name: String
    private(set) var cbPeripheral: CBPeripheral?
    
    static let mock = Peripheral(id: UUID().uuidString, name: "Mock")
    
    init(with peripheral: CBPeripheral) {
        self.id = peripheral.identifier.uuidString
        self.name = peripheral.name ?? LocalizedString.deviceNameUnknown()
        self.cbPeripheral = peripheral
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

extension Peripheral: Hashable, Identifiable {}
