//
//  PairingStoring.swift
//  Rogalo
//
//  Created by Jan on 13.12.2020.
//

import Combine

protocol PairingStoring {
    var state: CurrentValueSubject<PairingStoreState, Never> { get }
    
    func didSelect(peripheral: Peripheral)
}
