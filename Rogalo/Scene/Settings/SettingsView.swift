//
//  SettingsView.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import SwiftUI

struct SettingsView: View {
    let model: SettingsViewModel
    weak var coordinator: SettingsTabEventHandling?
    
    init(model: SettingsViewModel, actionHandler: SettingsTabEventHandling?) {
        self.model = model
        self.coordinator = actionHandler
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    if model.deviceState != .connected {
                        ConnectionStateView(connectionState: model.deviceState, eventHandler: coordinator)
                            .layoutPriority(1)
                    }
                    AppText("\(LocalizedString.settingsPairedDeviceTitle()): \(model.deviceName)", style: .caption)
                    Divider()
                    AppButton(LocalizedString.settingsForgetDeviceAction(), style: .destructive) {
                        coordinator?.handle(event: .unpairTapped)
                    }
                }
                .frame(minHeight: geometry.size.height, alignment: .topLeading)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            model: .empty,
            actionHandler: nil
        )
    }
}
