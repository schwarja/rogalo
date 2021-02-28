//
//  PairingNavigationView.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import SwiftUI

struct PairingNavigationView: View {
    let store: PairingStoring
    weak var coordinator: PairingNavigationViewEventHandling?
    
    @State var state: PairingStoreState = .initial
    
    init(store: PairingStoring, coordinator: PairingNavigationViewEventHandling) {
        self.store = store
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationView {
            PeripheralListView(state: state) { peripheral in
                store.didSelect(peripheral: peripheral)
            } openSettings: {
                coordinator?.handle(event: .openSettings)
            }
            .navigationBarTitle(LocalizedString.pairingTitle())
        }
        .onReceive(store.state, perform: { self.state = $0 })
    }
}
