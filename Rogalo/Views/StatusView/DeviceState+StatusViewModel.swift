//
//  DeviceState+StatusViewModel.swift
//  Rogalo
//
//  Created by Jan on 21.03.2021.
//

import Foundation

extension DeviceState {
    var statusViewModel: StatusViewModel {
        switch self {
        case .connected:
            return StatusViewModel(
                message: LocalizedString.pairingStateConnected(),
                resolutionText: nil,
                color: .appSuccess
            )
        case .connecting:
            return StatusViewModel(
                message: LocalizedString.pairingStateConnecting(),
                resolutionText: nil,
                color: .appFailure
            )
        case .failed(let error):
            return StatusViewModel(
                message: error.errorDescription ?? "",
                resolutionText: error.resolutionDescription,
                color: .appFailure
            )
        }
    }
}
