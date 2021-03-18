//
//  CharacteristicsView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct ValuesView: View {
    let connectionState: DeviceState
    let characteristics: [CharacteristicStoring]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ConnectionStateView(connectionState: connectionState, eventHandler: nil)
                        .layoutPriority(1)
                    
                    if characteristics.isEmpty {
                        Spacer()
                        AppText(LocalizedString.deviceValuesNoData(), style: .headline)
                        Spacer()
                    } else {
                        ForEach(characteristics, id: \.value) { characteristic in
                            CharacteristicView(store: characteristic)
                                .frame(maxHeight: .infinity)
                        }
                    }
                }
                .frame(minHeight: geometry.size.height)
            }
        }
    }
}

struct ValuesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ValuesView(
                connectionState: .failed(error: .bleUnauthorized),
                characteristics: []
            )
            ValuesView(
                connectionState: .connected,
                characteristics: [
                    CharacteristicStore(value: .temperatureEngine(value: 150)),
                    CharacteristicStore(value: .temperatureExhaust(value: 150)),
                    CharacteristicStore(value: .rpm(value: 8000)),
                    CharacteristicStore(value: .voltage(value: 30)),
                    CharacteristicStore(value: .flightTime(value: 7480))
                ]
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (1st generation)"))
        }
    }
}
