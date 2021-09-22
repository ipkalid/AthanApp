//
//  ContentView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import SwiftUI
import Adhan

let backgroundColor = LinearGradient(gradient: Gradient(colors: [Color(hex: "0081A7"), Color(hex: "00AFB9")]),startPoint: .top,endPoint: .bottom)

struct AppTapView: View {
        
    var body: some View {
    
            TabView(){
                PrayersTimeView()
                    .tabItem {TabIcon(label: "أذان", iconName: "Athan")}
    
                AthkarView()
                    .tabItem {TabIcon(label: "أذكار", iconName: "Athkar")}
    
                Text("View 2")
                    .tabItem {TabIcon(label: "تسبيح", iconName: "Tasbih")}
    
    
                Text("View 3")
                    .tabItem {TabIcon(label: "More", iconName: "Tasbih")}
                
            }
        
    }

 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTapView()
    }
}

struct TabIcon: View {
    var label:String
    var iconName:String
    var body: some View {
        VStack{
            Image(iconName)
                .renderingMode(.template)
            Text(label)
        }
    }
}
