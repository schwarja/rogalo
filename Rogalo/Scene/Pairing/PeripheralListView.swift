//
//  ContentView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

protocol PeriperalListViewEventHandling: ConnectionStateViewEventHandling {
    func handle(event: PeriperalListViewEvent)
}

extension PeriperalListViewEventHandling {
    func handle(event: ConnectionStateViewEvent) {
        switch event {
        case .openSettingsTapped:
            handle(event: PeriperalListViewEvent.openSettingsTapped)
        }
    }
}

enum PeriperalListViewEvent {
    case openSettingsTapped
    case didSelect(peripheral: Peripheral)
}

struct PeripheralListView: View {
    let model: PeripheralListViewModel
    let actionHandler: PeriperalListViewEventHandling?
    
    var body: some View {
        VStack {
            if case .failed = model.connectionState {
                ConnectionStateView(connectionState: model.connectionState, eventHandler: actionHandler)
            }
            
            AppText(LocalizedString.pairingSelectDeviceFromListTitle(), style: .body)
                .padding(8)
                .frame(maxWidth: .infinity)

            List(model.peripherals, id: \.id) { peripheral in
                AppButton(peripheral.name) {
                        actionHandler?.handle(event: .didSelect(peripheral: peripheral))
                }
            }
            .listStyle(GroupedListStyle())
        }
        .frame(alignment: .top)
    }
}
