//
//  CharacteristicsTab.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct ValuesTab: View {
    let store: ValuesStoring
    
    @State var connectionState = Device.State.connecting
    @State var characteristics: [CharacteristicStoring] = []

    var body: some View {
        NavigationView {
            ValuesView(
                    connectionState: connectionState,
                    characteristics: characteristics
                )
                .navigationBarTitle("Values")
        }
        .onReceive(store.connectionState, perform: { self.connectionState = $0 })
        .onReceive(store.characteristics, perform: { self.characteristics = $0 })
    }
}

struct ValuesTab_Previews: PreviewProvider {
    static var previews: some View {
        ValuesTab(store: MockValuesStore())
    }
}
