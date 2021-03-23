//
//  Color+AppColors.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import SwiftUI

extension Color {
    static let appBackground = R.color.backgroundColor.color
    static let appBackgroundInverted = R.color.textColor.color

    static let appText = R.color.textColor.color
    static let appTextInverted = R.color.textInvertedColor.color

    static let appSuccess = R.color.successIndicationColor.color
    static let appFailure = R.color.failureIndicationColor.color
    
    static let appTint = R.color.tintColor.color
    
    static let appDestructiveAction = R.color.failureIndicationColor.color
}
