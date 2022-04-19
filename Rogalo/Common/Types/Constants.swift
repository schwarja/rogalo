//
//  Constants.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import UIKit

enum Constants {
    static let settingsUrl: URL = {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            fatalError("Settings URL couldn't be constructed")
        }
        
        return url
    }()
    
    static var currentLocalization: SupportedLocalization {
        guard Bundle.main.preferredLocalizations.first != SupportedLocalization.czech.rawValue else {
            return .czech
        }
        
        return .english
    }
}
