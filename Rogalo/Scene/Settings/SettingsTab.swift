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
                Text("Paired device: \(device.peripheral.name)")
                Divider()
                Button("Forget device") {
                    coordinator?.handle(event: .unpair)
                }
            }
            .navigationBarTitle("Settings")
        }
        .onReceive(store.device, perform: { self.device = $0 })
    }
}
