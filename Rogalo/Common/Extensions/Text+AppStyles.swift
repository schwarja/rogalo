//
//  Text+AppStyles.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import SwiftUI

extension Text {
    func apply(style: AppTextStyle) -> Text {
        self
            .font(style.font)
            .foregroundColor(style.color)
    }
}
