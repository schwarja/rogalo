//
//  CharacteristicsView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct ValuesView: View {
    let connectionState: DeviceState
    let characteristics: [DeviceValueStoring]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    StatusView(model: connectionState.statusViewModel, eventHandler: nil)
                        .layoutPriority(1)
                    
                    if characteristics.isEmpty {
                        Spacer()
                        AppText(LocalizedString.deviceValuesNoData(), style: .headline)
                        Spacer()
                    } else {
                        ForEach(characteristics, id: \.deviceValue) { characteristic in
                            ValueView(store: characteristic)
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
                    DeviceValueStore(value: .temperatureEngine(value: 150)),
                    DeviceValueStore(value: .temperatureExhaust(value: 150)),
                    DeviceValueStore(value: .rpm(value: 8000)),
                    DeviceValueStore(value: .voltage(value: 30)),
                    DeviceValueStore(value: .flightTime(value: 7480))
                ]
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (1st generation)"))
        }
    }
}
