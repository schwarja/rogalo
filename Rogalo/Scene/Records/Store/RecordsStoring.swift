//
//  RecordsStoring.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Combine
import Foundation

protocol RecordsStoring {
    var connectionState: AnyPublisher<Device.State, Never> { get }
    var characteristics: AnyPublisher<[CharacteristicStoring], Never> { get }
}
