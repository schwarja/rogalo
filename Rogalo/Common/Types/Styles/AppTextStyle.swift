//
//  TextStyle.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import SwiftUI

enum AppTextStyle: TextualStyle {
    case caption
    case body
    case bodyInverted
    case headline
    case navigationTitle
    case navigationTitleLarge
    case value
    case tab
    
    var font: Font {
        switch self {
        case .caption:
            return Font.caption
        case .body, .bodyInverted:
            return Font.body
        case .headline:
            return Font.headline
        case .navigationTitle:
            return Font.title
        case .navigationTitleLarge:
            return Font.largeTitle
        case .value:
            return Font.system(size: 50)
        case .tab:
            return Font.body
        }
    }
    
    var uiFont: UIFont? {
        switch self {
        case .navigationTitle:
            return UIFont.preferredFont(forTextStyle: .title2)
        case .navigationTitleLarge:
            return UIFont.preferredFont(forTextStyle: .largeTitle)
        default:
            return nil
        }
    }
    
    var color: Color {
        switch self {
        case .bodyInverted:
            return Color.appTextInverted
        default:
            return Color.appText
        }
    }
}
