//
//  SettingsViewStoring.swift
//  Rogalo
//
//  Created by Jan on 07.03.2021.
//

import Combine
import SwiftUI

protocol SettingsViewStoring {
    var model: AnyPublisher<SettingsViewModel, Never> { get }
    
    func didUpdate(rpmMultiplier: String)
    func didUpdate(batteryType: String)
}
