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
                            AppText(LocalizedString.valuesTitle(), style: .tab)
                        }
                case .records(let view):
                    view
                        .tabItem {
                            Image(systemName: "clock")
                            AppText(LocalizedString.recordsTitle(), style: .tab)
                        }
                case .settings(let view):
                    view
                        .tabItem {
                            Image(systemName: "gearshape")
                            AppText(LocalizedString.settingsTitle(), style: .tab)
                        }
                }
            }
        }
        .accentColor(.appTint)
    }
}
