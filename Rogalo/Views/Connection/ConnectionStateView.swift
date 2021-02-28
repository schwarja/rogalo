//
//  ConnectionStateView.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import SwiftUI

struct ConnectionStateView: View {
    let connectionState: Device.State
    
    var body: some View {
        let text: String
        let color: Color
        
        switch connectionState {
        case .connected:
            text = LocalizedString.pairingStateConnected()
            color = .appSuccess
        case .connecting, .failed:
            text = LocalizedString.pairingStateConnecting()
            color = .appFailure
        }
        
        return AppText(text, style: .bodyInverted)
            .minimumScaleFactor(0.5)
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(color)
    }
}

struct ConnectionStateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConnectionStateView(connectionState: .connected)
            ConnectionStateView(connectionState: .connecting)
        }
    }
}
