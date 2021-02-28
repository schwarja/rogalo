//
//  AppText.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import SwiftUI

struct AppText: View {
    let text: String
    let style: AppTextStyle
    
    init(_ text: String, style: AppTextStyle = .body) {
        self.text = text
        self.style = style
    }
    
    var body: some View {
        Text(text)
            .apply(style: style)
    }
}

struct AppText_Previews: PreviewProvider {
    static var previews: some View {
        AppText("Hello world")
    }
}
