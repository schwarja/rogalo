//
//  Storage.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

protocol Storage {
    var pairedDevice: CurrentValueSubject<Peripheral?, Never> { get }
}
