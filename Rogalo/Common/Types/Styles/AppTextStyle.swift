//
//  TextStyle.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import SwiftUI

enum AppTextStyle: TextualStyle {
    case caption
    case captionInverted
    case body
    case bodyInverted
    case headline
    case navigationTitle
    case navigationTitleLarge
    case value
    case tab
    
    var font: Font {
        switch self {
        case .caption, .captionInverted:
            return Font.caption
        case .body, .bodyInverted:
            return Font.body
        case .headline:
            return Font.headline
        case .navigationTitle:
            return Font.system(size: 20, weight: .semibold, design: .default)
        case .navigationTitleLarge:
            return Font.system(size: 40, weight: .bold, design: .default)
        case .value:
            return Font.system(size: 50)
        case .tab:
            return Font.body
        }
    }
    
    var uiFont: UIFont? {
        switch self {
        case .navigationTitle:
            return UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .navigationTitleLarge:
            return UIFont.systemFont(ofSize: 40, weight: .bold)
        default:
            return nil
        }
    }
    
    var color: Color {
        switch self {
        case .bodyInverted, .captionInverted:
            return Color.appTextInverted
        default:
            return Color.appText
        }
    }
}
