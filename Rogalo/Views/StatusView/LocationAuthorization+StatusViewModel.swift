//
//  LocationAuthorization+StatusViewModel.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Foundation

extension LocationAuthorization {
    var statusViewModel: StatusViewModel {
        switch self {
        case .authorized, .notDetermined:
            return StatusViewModel(
                message: "",
                resolutionText: "",
                color: .appSuccess
            )
        case .authorizedNotPrecise:
            return StatusViewModel(
                message: LocalizedString.generalAlertLocationNotPreciseTitle(),
                resolutionText: LocalizedString.generalAlertLocationNotPreciseSubtitle(),
                color: .appFailure
            )
        case .denied:
            return StatusViewModel(
                message: LocalizedString.generalAlertLocationPermissionDeniedTitle(),
                resolutionText: LocalizedString.generalAlertLocationPermissionDeniedSubtitle(),
                color: .appFailure
            )
        }
    }
}
