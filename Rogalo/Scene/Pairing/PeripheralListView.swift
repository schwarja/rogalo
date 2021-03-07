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
        List {
            if case .failed = model.connectionState {
                Section(footer: ConnectionStateView(connectionState: model.connectionState, eventHandler: actionHandler)) {}
                    .listRowInsets(EdgeInsets())
            }
            
            let devicesSection = Section(
                header: AppText(LocalizedString.pairingSelectDeviceFromListTitle(), style: .body).padding([.vertical], 8)) {
                ForEach(model.peripherals, id: \.id) { peripheral in
                    Button(action: {
                        actionHandler?.handle(event: .didSelect(peripheral: peripheral))
                    }, label: {
                        AppText(peripheral.name, style: .body)
                    })
                }
            }

            if #available(iOS 14.0, *) {
                devicesSection
                    .textCase(nil)
            } else {
                devicesSection
            }
        }
        .listStyle(GroupedListStyle())
    }
}
