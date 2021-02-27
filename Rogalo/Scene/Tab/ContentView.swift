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
            case .records:
                return 1
            case .settings:
                return 2
            }
        }
        
        case characteristics(view: ValuesTab)
        case records(view: RecordsTab)
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
                        .tabItem {
                            Image(systemName: "chart.bar")
                            Text("Values")
                        }
                case .records(let view):
                    view
                        .tabItem {
                            Image(systemName: "clock")
                            Text("Records")
                        }
                case .settings(let view):
                    view
                        .tabItem {
                            Image(systemName: "iphone.radiowaves.left.and.right")
                            Text("Settings")
                        }
                }
            }
        }
    }
}
