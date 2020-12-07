//
//  CharacteristicsTab.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct CharacteristicsTab: View {
    let dependency: AppDependency
    
    let engineStore: EngineStore
    
    init(dependency: AppDependency) {
        self.dependency = dependency
        
        self.engineStore = EngineStore(bluetoothManager: dependency.bluetoothManager)
    }

    var body: some View {
        NavigationView {
            CharacteristicsView(store: engineStore)
                .navigationBarTitle("Engine")
        }
    }
}

struct CharacteristicsTab_Previews: PreviewProvider {
    static var previews: some View {
        CharacteristicsTab(dependency: AppDependency())
    }
}
