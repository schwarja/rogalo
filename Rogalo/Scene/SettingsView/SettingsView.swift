//
//  SettingsView.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import SwiftUI

struct SettingsView: View {
    let store: SettingsViewStoring
    weak var coordinator: SettingsTabEventHandling?
    
    @State var model: SettingsViewModel = .empty

    init(store: SettingsViewStoring, actionHandler: SettingsTabEventHandling?) {
        self.store = store
        self.coordinator = actionHandler
    }
    
    var body: some View {
        List {
            SettingsAlertHeader(deviceState: model.deviceState, notificationsAutorization: model.notificationsAutorization, coordinator: coordinator)
                .listRowInsets(EdgeInsets())
            
            Section(
                footer: SettingsPairedDeviceFooterView(deviceName: model.deviceName, coordinator: coordinator) ) {
                Picker(LocalizedString.settingsRevolutionsMultiplierTitle(), selection: $model.revolutionsMultiplier) {
                    ForEach(model.revolutionsMultipliers, id: \.self) { value in
                        Text(value)
                    }
                }
                .font(AppTextStyle.body.font)
                .foregroundColor(AppTextStyle.body.color)
                .onReceive([self.model].publisher.first(), perform: { value in
                    self.store.didUpdate(revolutionsMultiplier: value.revolutionsMultiplier)
                })
            }
            
        }
        .listStyle(GroupedListStyle())
        .onReceive(store.model, perform: { self.model = $0 })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            store: MockSettingsViewStore(),
            actionHandler: nil
        )
    }
}
