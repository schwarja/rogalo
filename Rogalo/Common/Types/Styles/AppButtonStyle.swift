//
//  AppButtonStyle.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import SwiftUI

enum AppButtonStyle: TextualStyle {
    case action
    
    var color: Color {
        .appTint
    }
    
    var font: Font {
        .subheadline
    }
}
