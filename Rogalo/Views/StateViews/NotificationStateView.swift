//
//  NotificationStateView.swift
//  Rogalo
//
//  Created by Jan on 28.02.2021.
//

import SwiftUI

protocol NotificationStateViewEventHandling {
    func handle(event: NotificationStateViewEvent)
}

enum NotificationStateViewEvent {
    case openSettingsTapped
}

struct NotificationStateView: View {
    let notificationsState: NotificationAuthorizationStatus
    let eventHandler: NotificationStateViewEventHandling?
    
    var body: some View {
        let text: String?
        let color: Color
        let resolutionText: String?
        
        switch notificationsState {
        case .authorized, .initial:
            text = nil
            resolutionText = nil
            color = .appSuccess
        case .denied:
            text = LocalizedString.generalAlertNotificationPermissionDeniedTitle()
            resolutionText = LocalizedString.generalAlertNotificationPermissionDeniedSubtitle()
            color = .appFailure
        }
        
        return VStack {
            if let text = text {
                AppText(text, style: .bodyInverted)
                    .padding(8)
            }

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

struct NotificationStateView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationStateView(notificationsState: .denied, eventHandler: nil)
    }
}
