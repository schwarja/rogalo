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
}
