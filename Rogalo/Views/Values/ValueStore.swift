//
//  ValueStore.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Foundation

struct ValueStore: ValueStoring {
    let value: Value
    let scale: ValueScale?
    
    init(value: Value, scale: ValueScale? = nil) {
        self.value = value
        self.scale = scale
    }
}
