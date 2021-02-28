//
//  ConnectionStateView.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import SwiftUI

protocol ConnectionStateViewEventHandling {
    func handle(event: ConnectionStateViewEvent)
}

enum ConnectionStateViewEvent {
    case openSettingsTapped
}

struct ConnectionStateView: View {
    let connectionState: DeviceState
    let eventHandler: ConnectionStateViewEventHandling?
    
    var body: some View {
        let text: String
        let color: Color
        let resolutionText: String?
        
        switch connectionState {
        case .connected:
            text = LocalizedString.pairingStateConnected()
            resolutionText = nil
            color = .appSuccess
        case .connecting:
            text = LocalizedString.pairingStateConnecting()
            resolutionText = nil
            color = .appFailure
        case .failed(let error):
            text = error.errorDescription ?? ""
            resolutionText = error.resolutionDescription
            color = .appFailure
        }
        
        return VStack {
            AppText(text, style: .bodyInverted)
                .padding(8)

            if let resolution = resolutionText {
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
        .background(color)
    }
}

struct ConnectionStateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConnectionStateView(connectionState: .connected, eventHandler: nil)
            ConnectionStateView(connectionState: .connecting, eventHandler: nil)
            ConnectionStateView(connectionState: .failed(error: .bleUnauthorized), eventHandler: nil)
        }
    }
}
