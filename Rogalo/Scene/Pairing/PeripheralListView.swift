//
//  ContentView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct PeripheralListView: View {
    @ObservedObject var store: PairingStore
    
    var body: some View {
        if case .ready(let data) = store.state {
            List {
                ForEach(data) { peripheral in
                    Button(peripheral.name) {
                        store.pair(peripheral: peripheral)
                    }
                }
            }
        } else {
            Text("Loading")
        }
    }
}

struct PeripheralListView_Previews: PreviewProvider {
    static var previews: some View {
        PeripheralListView(store:
                            PairingStore(bluetoothManager: BluetoothManager()))
    }
}
