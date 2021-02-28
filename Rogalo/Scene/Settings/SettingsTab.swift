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
    
    @State var model: SettingsViewModel = .empty
    
    init(store: SettingsStoring, coordinator: SettingsTabEventHandling?) {
        self.store = store
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationView {
            SettingsView(model: model, actionHandler: coordinator)
                .navigationBarTitle(LocalizedString.settingsTitle())
        }
        .onReceive(store.model, perform: { self.model = $0 })
    }
}
