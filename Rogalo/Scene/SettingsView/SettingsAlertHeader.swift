//
//  SettingsAlertHeader.swift
//  Rogalo
//
//  Created by Jan on 07.03.2021.
//

import SwiftUI

struct SettingsAlertHeader: View {
    let deviceState: DeviceState
    let notificationsAutorization: NotificationAuthorizationStatus
    weak var coordinator: SettingsTabEventHandling?

    var body: some View {
        guard deviceState != .connected || notificationsAutorization == .denied else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            Section(footer: content()) {}
        )
    }
    
    private func content() -> some View {
        VStack {
            if deviceState != .connected {
                StatusView(model: deviceState.statusViewModel, eventHandler: coordinator)
                    .layoutPriority(1)
            }
            if notificationsAutorization == .denied {
                StatusView(model: notificationsAutorization.statusViewModel, eventHandler: coordinator)
            }
        }
    }
}

struct SettingsAlertHeader_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAlertHeader(deviceState: .connected, notificationsAutorization: .denied)
    }
}
