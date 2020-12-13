//
//  TabView.swift
//  Rogalo
//
//  Created by Jan on 06.12.2020.
//

import SwiftUI

struct ContentView: View {
    enum Tab: Identifiable {
        var id: Int {
            switch self {
            case .characteristics:
                return 0
            case .settings:
                return 1
            }
        }
        
        case characteristics(view: CharacteristicsTab)
        case settings(view: SettingsTab)
    }
    
    let store: ContentStoring
    let tabs: [Tab]
    
    var body: some View {
        TabView {
            ForEach(tabs) { tab in
                switch tab {
                case .characteristics(let view):
                    view
                        .tabItem { Text("Engine") }
                case .settings(let view):
                    view
                        .tabItem { Text("Settings") }
                }
            }
        }
    }
}
