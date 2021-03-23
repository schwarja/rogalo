//
//  DeviceValueStoring.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Foundation

protocol DeviceValueStoring: ValueStoring {
    var deviceValue: DeviceValue { get }
}

extension DeviceValueStoring {
    var value: Value {
        deviceValue
    }
}
