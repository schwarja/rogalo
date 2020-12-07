//
//  TabView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct ContentView: View {
    let dependency: AppDependency
    
    var body: some View {
        TabView {
            CharacteristicsTab(dependency: dependency)
                .tabItem { Text("Engine") }
            SettingsTab(dependency: dependency)
                .tabItem { Text("Settings") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dependency: AppDependency())
    }
}
