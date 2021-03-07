//
//  MockSettingsStore.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

class MockSettingsStore: SettingsStoring {
    var settingsViewStore: SettingsViewStoring {
        MockSettingsViewStore()
    }
}
