//
//  MockSettingsViewStore.swift
//  Rogalo
//
//  Created by Jan on 07.03.2021.
//

import Combine
import SwiftUI

class MockSettingsViewStore: SettingsViewStoring {
    var model: AnyPublisher<SettingsViewModel, Never> {
        Just<SettingsViewModel>(.empty).eraseToAnyPublisher()
    }
    
    func didUpdate(revolutionsMultiplier: String) {
        
    }
}
