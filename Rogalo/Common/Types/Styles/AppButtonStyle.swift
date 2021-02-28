//
//  AppButtonStyle.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import SwiftUI

enum AppButtonStyle: TextualStyle, ViewWithBackgroundStyle {
    case action
    case actionInverted
    case destructive
    
    var color: Color {
        switch self {
        case .action:
            return Color.appTint
        case .destructive, .actionInverted:
            return Color.appTextInverted
        }
    }
    
    var font: Font {
        .subheadline
    }
    
    var padding: CGFloat {
        16
    }
    
    var backgroundColor: Color {
        switch self {
        case .action, .actionInverted:
            return Color.appBackground.opacity(0.1)
        case .destructive:
            return Color.appDestructiveAction
        }
    }
}
