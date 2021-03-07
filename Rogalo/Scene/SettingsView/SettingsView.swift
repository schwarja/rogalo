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
                Picker(LocalizedString.settingsRevolutionsMultiplierTitle(), selection: $model.rpmMultiplier) {
                    ForEach(model.rpmMultipliers, id: \.self) { value in
                        Text(value)
                    }
                }
                .font(AppTextStyle.body.font)
                .foregroundColor(AppTextStyle.body.color)
                .onReceive([self.model].publisher.first(), perform: { value in
                    self.store.didUpdate(rpmMultiplier: value.rpmMultiplier)
                })
                
                Picker(LocalizedString.settingsBatteryTypeTitle(), selection: $model.batteryType) {
                    ForEach(model.batteryTypes, id: \.self) { value in
                        Text(value)
                    }
                }
                .font(AppTextStyle.body.font)
                .foregroundColor(AppTextStyle.body.color)
                .onReceive([self.model].publisher.first(), perform: { value in
                    self.store.didUpdate(batteryType: value.batteryType)
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
