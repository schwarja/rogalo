//
//  ContentView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct PeripheralListView: View {
    let state: PairingStoreState
    let selection: (Peripheral) -> Void
    let openSettings: () -> Void
    
    var body: some View {
        switch state {
        case .ready(let data):
            List {
                ForEach(data) { peripheral in
                    Button(peripheral.name) {
                        selection(peripheral)
                    }
                }
            }
        case .loading, .initial:
            Text("Searching")
        case .unauthorized:
            VStack {
                Text("Permission denied")
                Button("Go to Settings") {
                    openSettings()
                }
            }
        case .notAvailable:
            Text("Bluetooth is turned off")
        }
    }
}
