//
//  SettingsView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct SettingsTab: View {
    let store: SettingsStoring
    weak var coordinator: SettingsTabEventHandling?
    
    init(store: SettingsStoring, coordinator: SettingsTabEventHandling?) {
        self.store = store
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationView {
            SettingsView(store: store.settingsViewStore, actionHandler: coordinator)
                .navigationBarTitle(LocalizedString.settingsTitle())
        }
    }
}
