//
//  CharacteristicsView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct ValuesView: View {
    let connectionState: Device.State
    let characteristics: [CharacteristicStoring]
    
    var body: some View {
        VStack {
            ConnectionStateView(connectionState: connectionState)
            
            ForEach(characteristics, id: \.value) { characteristic in
                CharacteristicView(store: characteristic)
                    .frame(maxHeight: .infinity)
            }
        }
    }
}

struct ValuesView_Previews: PreviewProvider {
    static var previews: some View {
        ValuesView(
            connectionState: .connecting,
            characteristics: [
                CharacteristicStore(value: .temperature(value: 150)),
                CharacteristicStore(value: .rpm(value: 8000)),
                CharacteristicStore(value: .voltage(value: 30)),
                CharacteristicStore(value: .flightTime(value: 7480))
            ]
        )
    }
}
