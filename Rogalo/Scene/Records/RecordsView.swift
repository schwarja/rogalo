//
//  RecordsView.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import SwiftUI

struct RecordsView: View {
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

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecordsView(
                connectionState: .connecting,
                characteristics: []
            )
            RecordsView(
                connectionState: .connected,
                characteristics: [
                    CharacteristicStore(value: .rpm(value: 8000))
                ]
            )

        }
    }
}
