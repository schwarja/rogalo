//
//  BluetoothManager.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import Combine
import CoreBluetooth

class BluetoothManager: NSObject {
    private let central: CBCentralManager
    private let service = CBUUID(string: "0xFFE0")
    private let characteristic = CBUUID(string: "0xFFE1")
    
    @Published private var list: Set<CBPeripheral> = []
    @Published private var device: Engine?
    
    override init() {
        central = CBCentralManager()
        
        super.init()
        
        central.delegate = self
    }
}

extension BluetoothManager: BluetoothManaging {
    var peripherals: AnyPublisher<[Peripheral], Never> {
        $list
            .map { set in
                Array(set.map { Peripheral(with: $0) })
            }
            .eraseToAnyPublisher()
    }
    
    var engine: AnyPublisher<Engine?, Never> {
        $device.eraseToAnyPublisher()
    }
    
    func pair(peripheral: Peripheral) {
        guard let cbperipheral = list.first(where: { $0.identifier.uuidString == peripheral.id }) else {
            return
        }
        
        central.stopScan()
        central.connect(cbperipheral)
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            central.scanForPeripherals(withServices: [service])
        default:
            break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        list.insert(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        print("Connected")
        device = Engine()
        
        peripheral.delegate = self
        peripheral.discoverServices([service])
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
        print("Disconnected")
        device = nil
    }
}

extension BluetoothManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let service = peripheral.services?.first else {
            return
        }
        
        print("Service discovered")
        peripheral.discoverCharacteristics([characteristic], for: service)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristic = service.characteristics?.first else {
            return
        }
        
        print("Characteristics discovered")
        
        if characteristic.properties.contains(.notify) {
            peripheral.setNotifyValue(true, for: characteristic)
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let data = characteristic.value else {
            return
        }
        
        print("Did update value")
        
        guard let value = String(data: data, encoding: .utf8) else {
            return
        }
        
        device?.append(value)
    }
}
