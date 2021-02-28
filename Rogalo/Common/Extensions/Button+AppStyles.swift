//
//  Button+AppStyles.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import SwiftUI

extension Button {
    func apply(style: AppButtonStyle) -> some View {
        self
            .font(style.font)
            .foregroundColor(style.color)
    }
}
