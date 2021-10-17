//
//  ContentView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import SwiftUI
import UIKit

struct AppTapView: View {
    @State private var selectedIndex = 0

    let tabBarImages = ["Athan", "Tasbih", "Athkar", "Tasbih"]

    init() {
        UITabBar.appearance().backgroundColor = .white
    }

    var body: some View {
        TabView {
            PrayersTimeView()
                .tag(0)
                .tabItem {
                    Image(tabBarImages[0])
                        .renderingMode(.template)
                    Text("الصلاة")
                }

            AthkarView()
                .tag(2)
                .tabItem {
                    Image(tabBarImages[2])
                        .renderingMode(.template)
                    Text("الأذكار")
                }

            SettingView()
                .tag(3)
                .tabItem {
                    Image(systemName: "gear")
                        .renderingMode(.template)
                    Text("الإعدادات")
                }
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTapView()
    }
}

struct TabIcon: View {
    var label: String
    var iconName: String
    var body: some View {
        VStack {
            Image(iconName)
                .renderingMode(.template)
            Text(label)
                .font(.caption2)
        }
    }
}
