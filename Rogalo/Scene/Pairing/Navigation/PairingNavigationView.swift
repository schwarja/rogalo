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
    
    @State var model: PeripheralListViewModel = .empty
    
    init(store: PairingStoring, coordinator: PairingNavigationViewEventHandling) {
        self.store = store
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationView {
            PeripheralListView(model: model, actionHandler: coordinator)
                .navigationBarTitle(LocalizedString.pairingTitle())
        }
        .onReceive(store.model, perform: { self.model = $0 })
    }
}
