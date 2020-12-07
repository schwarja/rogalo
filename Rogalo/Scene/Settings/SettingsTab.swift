//
//  SettingsView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct SettingsTab: View {
    let dependency: AppDependency
    
    let pairingStore: PairingStore
    
    init(dependency: AppDependency) {
        self.dependency = dependency
        
        self.pairingStore = PairingStore(bluetoothManager: dependency.bluetoothManager)
    }

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Pairing", destination: PeripheralListView(store: pairingStore))
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab(dependency: AppDependency())
    }
}
