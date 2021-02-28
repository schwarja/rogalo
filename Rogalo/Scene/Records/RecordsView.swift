//
//  RecordsView.swift
//  Rogalo
//
//  Created by Jan on 27.02.2021.
//

import SwiftUI

struct RecordsView: View {
    let connectionState: Device.State
    let characteristics: [CharacteristicStoring]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ConnectionStateView(connectionState: connectionState)
                    
                    ForEach(characteristics, id: \.value) { characteristic in
                        CharacteristicView(store: characteristic)
                            .frame(maxHeight: .infinity)
                    }
                }
                .frame(minHeight: geometry.size.height)
            }
        }
    }
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView(
            connectionState: .connecting,
            characteristics: [
                CharacteristicStore(value: .rpm(value: 8000))
            ]
        )
    }
}
