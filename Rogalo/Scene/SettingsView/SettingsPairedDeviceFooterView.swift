//
//  SettingsPairedDeviceFooterView.swift
//  Rogalo
//
//  Created by Jan on 07.03.2021.
//

import SwiftUI

struct SettingsPairedDeviceFooterView: View {
    let deviceName: String
    weak var coordinator: SettingsTabEventHandling?

    var body: some View {
        VStack {
            Spacer()
            
            AppText(LocalizedString.settingsPairedDeviceTitle(), style: .headline)
                .padding(4)
                .frame(maxWidth: .infinity)
            AppText(deviceName, style: .body)
                .padding(4)
            
            Spacer()
            
            AppButton(LocalizedString.settingsForgetDeviceAction(), style: .destructive) {
                coordinator?.handle(event: .unpairTapped)
            }
            .padding()
        }
    }
}

struct SettingsPairedDeviceFooterView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPairedDeviceFooterView(deviceName: "Device name")
    }
}
