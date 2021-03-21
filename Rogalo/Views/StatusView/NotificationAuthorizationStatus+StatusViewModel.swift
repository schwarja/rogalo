//
//  NotificationAuthorizationStatus+StatusViewModel.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Foundation

extension NotificationAuthorizationStatus {
    var statusViewModel: StatusViewModel {
        switch self {
        case .authorized, .initial:
            return StatusViewModel(
                message: "",
                resolutionText: nil,
                color: .appSuccess
            )
        case .denied:
            return StatusViewModel(
                message: LocalizedString.generalAlertNotificationPermissionDeniedTitle(),
                resolutionText: LocalizedString.generalAlertNotificationPermissionDeniedSubtitle(),
                color: .appFailure
            )
        }
    }
}
