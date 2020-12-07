//
//  Peripheral.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import CoreBluetooth

struct Peripheral {
    let id: String
    let name: String
    
    init(with peripheral: CBPeripheral) {
        self.id = peripheral.identifier.uuidString
        self.name = peripheral.name ?? "<unknown>"
    }
}

extension Peripheral: Hashable, Identifiable {}
