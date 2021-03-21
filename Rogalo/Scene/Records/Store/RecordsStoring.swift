//
//  RecordsStoring.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import Combine
import Foundation

protocol RecordsStoring {
    var connectionState: AnyPublisher<DeviceState, Never> { get }
    var characteristics: AnyPublisher<[DeviceValueStoring], Never> { get }
}
