//
//  ContentView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import SwiftUI
import UIKit

struct AppTapView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let tabBarImages = ["Athan", "Tasbih", "Athkar", "Tasbih"]

    init() {
        UITabBar.appearance().backgroundColor = .white
    }

    @State var selectionTab: Int = 0

    var body: some View {
        TabView(selection: $selectionTab) {
            PrayersTimeView()
                .tag(0)
                .tabItem {
                    Image(tabBarImages[0])
                        .renderingMode(.template)
                    Text("Salah")
                        .overlay {
                            Text("j")
                        }
                }

            QiblahView()
                .tag(1)
                .tabItem {
                    Image(systemName: "safari")
                        .renderingMode(.template)
                    Text("Qiblah")
                }

            AthkarView()
                .tag(2)
                .tabItem {
                    Image(tabBarImages[2])
                        .renderingMode(.template)
                    Text("Athkar")
                }

            SettingView()
                .tag(3)
                .tabItem {
                    Image(systemName: "gear")
                        .renderingMode(.template)
                    Text("Settings")
                }
        }
        .navigationBarHidden(true)
        .navigationBarHidden(true)
        .accentColor(.black)
    }
}
