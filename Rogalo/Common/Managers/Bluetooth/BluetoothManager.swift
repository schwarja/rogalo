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
    
    private var numberOfListeners = 0 {
        didSet {
            if numberOfListeners > 0 {
                startScanningIfNeeded()
            } else {
                stopScanning()
            }
        }
    }
    
    @Published private var list: Set<CBPeripheral> = []
    @Published private var device: Device?
    @Published private var managerStatus: BluetoothStatus = .initial
    
    private var pairingSubscription: AnyCancellable?
    
    override init() {
        central = CBCentralManager(delegate: nil, queue: DispatchQueue.global())
        
        super.init()
        
        central.delegate = self
    }
}

// MARK: - Bluetooth managing
extension BluetoothManager: BluetoothManaging {
    var status: AnyPublisher<BluetoothStatus, Never> {
        $managerStatus
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    var cbPeripherals: AnyPublisher<Set<CBPeripheral>, Never> {
        $list
            .handleEvents(
                receiveSubscription: { [weak self] _ in self?.numberOfListeners += 1 },
                receiveCompletion: { [weak self] _ in self?.numberOfListeners -= 1 },
                receiveCancel: { [weak self] in self?.numberOfListeners -= 1 }
            )
            .eraseToAnyPublisher()
    }
    
    var peripherals: AnyPublisher<[Peripheral], Never> {
        cbPeripherals
            .map { set in
                Array(set.map { Peripheral(with: $0) })
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    var connectedDevice: AnyPublisher<Device?, Never> {
        $device
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func connect(peripheral: Peripheral) {
        guard peripheral.id != device?.id else {
            return
        }
        
        if let paired = device, peripheral.id != paired.id {
            disconnectPeripheral(with: paired.id)
        }
        
        device = Device(peripheral: peripheral)
        
        connectPeripheral(with: peripheral.id)
    }
    
    func disconnect(peripheral: Peripheral) {
        disconnectPeripheral(with: peripheral.id)
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn, .resetting:
            managerStatus = .scanning
            if let id = device?.id {
                connectPeripheral(with: id)
            } else if numberOfListeners > 0 {
                startScanningIfNeeded()
            }
        case .poweredOff, .unknown:
            managerStatus = .notAvailable
            device?.state = .connecting
        case .unauthorized, .unsupported:
            managerStatus = .unauthorized
            device?.state = .connecting
        @unknown default:
            managerStatus = .notAvailable
            device?.state = .connecting
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        list.insert(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        device?.state = .connected
        
        peripheral.delegate = self
        peripheral.discoverServices([service])
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        device?.state = .connecting
        
        connectPeripheral(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            device?.state = .failed(error.localizedDescription)
        }
        
        connectPeripheral(peripheral)
    }
}

extension BluetoothManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let service = peripheral.services?.first else {
            return
        }
        
        peripheral.discoverCharacteristics([characteristic], for: service)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristic = service.characteristics?.first else {
            return
        }
        
        if characteristic.properties.contains(.notify) {
            peripheral.setNotifyValue(true, for: characteristic)
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let data = characteristic.value else {
            return
        }
        
        guard let value = String(data: data, encoding: .utf8) else {
            return
        }
        
        if device?.state != .connected {
            device?.state = .connected
        }
        
        device?.append(value)
    }
}

// MARK: - Private methods
private extension BluetoothManager {
    func startScanningIfNeeded() {
        guard !central.isScanning else {
            return
        }
        
        guard central.state == .poweredOn else {
            return
        }
        
        central.scanForPeripherals(withServices: [service])
    }
    
    func stopScanning() {
        guard central.isScanning else {
            return
        }
        
        guard numberOfListeners <= 0 else {
            return
        }
        
        central.stopScan()
        list = []
    }
    
    func connectPeripheral(with id: String) {
        guard let cbperipheral = list.first(where: { $0.identifier.uuidString == id }) else {
            scanForDeviceToConnect(id: id)
            return
        }
        
        connectPeripheral(cbperipheral)
    }
    
    func connectPeripheral(_ peripheral: CBPeripheral) {
        let connected = central.retrieveConnectedPeripherals(withServices: [service])
        guard !connected.contains(where: { $0.identifier == peripheral.identifier }) else {
            return
        }
        
        central.registerForConnectionEvents(options: nil)
        central.connect(peripheral)
    }
    
    func disconnectPeripheral(with id: String) {
        let connected = central.retrieveConnectedPeripherals(withServices: [service])
        
        for peripheral in connected where peripheral.identifier.uuidString == id {
            central.cancelPeripheralConnection(peripheral)
        }
        
        if device?.id == id {
            device = nil
        }
    }
    
    func scanForDeviceToConnect(id: String) {
        pairingSubscription = cbPeripherals.sink { [weak self] peripherals in
            if let peripheral = peripherals.first(where: { $0.identifier.uuidString == id }) {
                self?.connectPeripheral(peripheral)
                self?.pairingSubscription = nil
            }
        }
    }
}
