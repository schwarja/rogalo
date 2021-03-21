//
//  ConnectionStateView.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import SwiftUI

struct StatusView: View {
    let model: StatusViewModel
    let eventHandler: StatusViewEventHandling?
    
    var body: some View {
        VStack {
            AppText(model.message, style: .bodyInverted)
                .padding(8)

            if let resolution = model.resolutionText, eventHandler != nil {
                AppText(resolution, style: .captionInverted).multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 8)

                AppButton(
                    LocalizedString.generalAlertGoToSettingsAction(),
                    style: .actionInverted) {
                    eventHandler?.handle(event: .openSettingsTapped)
                }
                .padding(8)
            }
        }
        .frame(maxWidth: .infinity)
        .background(model.color)
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatusView(
                model: StatusViewModel(
                    message: LocalizedString.pairingStateConnected(),
                    resolutionText: nil,
                    color: .appSuccess
                ),
                eventHandler: nil
            )
            StatusView(
                model: StatusViewModel(
                    message: LocalizedString.pairingStateConnecting(),
                    resolutionText: nil,
                    color: .appFailure
                ),
                eventHandler: nil
            )
            StatusView(
                model: StatusViewModel(
                    message: DeviceStateError.bleUnauthorized.errorDescription ?? "",
                    resolutionText: DeviceStateError.bleUnauthorized.resolutionDescription,
                    color: .appFailure
                ),
                eventHandler: nil
            )
        }
    }
}
