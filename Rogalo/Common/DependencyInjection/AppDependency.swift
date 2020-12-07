//
//  AppDependency.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Foundation

struct AppDependency {
    enum DependencyType {
        case bluetoothManager
    }
    
    private var dependencies = [DependencyType: Any]()
    
    var bluetoothManager: BluetoothManaging {
        dependencies[.bluetoothManager] as! BluetoothManaging
    }
    
    init() {}
    
    mutating func register(_ dependency: Any, for type: DependencyType) {
        dependencies[type] = dependency
    }
}
