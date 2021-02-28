//
//  AppButton.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import SwiftUI

struct AppButton: View {
    let text: String
    let style: AppButtonStyle
    let action: () -> Void
    
    init(_ text: String, style: AppButtonStyle = .action, action: @escaping () -> Void) {
        self.text = text
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button(text, action: action)
            .apply(style: style)
    }
}
