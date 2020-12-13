//
//  CharacteristicsTab.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct CharacteristicsTab: View {
    let store: EngineStoring
    
    @State var engine = Device.mock

    var body: some View {
        NavigationView {
            CharacteristicsView(engine: engine)
                .navigationBarTitle("Engine")
        }
        .onReceive(store.engine, perform: { self.engine = $0 })
    }
}

struct CharacteristicsTab_Previews: PreviewProvider {
    static var previews: some View {
        CharacteristicsTab(store: MockEngineStore())
    }
}
