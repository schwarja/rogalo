//
//  CharacteristicScale.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import SwiftUI

struct CharacteristicScale {
    let midLocation: CGFloat
    let progress: CGFloat
    let order: Order
    
    var isCritical: Bool {
        switch order {
        case .asceding:
            return progress > (1+midLocation)/2
        case .descending:
            return progress < midLocation/2
        }
    }
    
    init(midLocation: CGFloat, progress: CGFloat, order: Order) {
        self.midLocation = min(1, max(0, midLocation))
        self.progress = min(1, max(0, progress))
        self.order = order
    }
}
