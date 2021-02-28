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
                    AppButton(peripheral.name) {
                        selection(peripheral)
                    }
                }
            }
        case .loading, .initial:
            AppText(LocalizedString.pairingSearchingTitle(), style: .caption)
        case .unauthorized:
            VStack {
                AppText(LocalizedString.generalAlertPermissionDeniedTitle(), style: .caption)
                AppButton(LocalizedString.generalAlertGoToSettingsAction()) {
                    openSettings()
                }
            }
        case .notAvailable:
            AppText(LocalizedString.pairingBluetoothTurnedOff(), style: .caption)
        }
    }
}
