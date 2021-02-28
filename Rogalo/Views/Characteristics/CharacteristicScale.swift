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
    
    init(midLocation: CGFloat, progress: CGFloat) {
        self.midLocation = min(1, max(0, midLocation))
        self.progress = min(1, max(0, progress))
    }
}
