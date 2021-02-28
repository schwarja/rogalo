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
    
    @State var device: Device = .mock
    
    init(store: SettingsStoring, coordinator: SettingsTabEventHandling?) {
        self.store = store
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationView {
            VStack {
                AppText("\(LocalizedString.settingsPairedDeviceTitle()): \(device.name)", style: .caption)
                Divider()
                Button(LocalizedString.settingsForgetDeviceAction()) {
                    coordinator?.handle(event: .unpair)
                }
            }
            .navigationBarTitle(LocalizedString.settingsTitle())
        }
        .onReceive(store.device, perform: { self.device = $0 })
    }
}
