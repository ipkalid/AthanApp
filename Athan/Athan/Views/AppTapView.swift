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
    @State private var selectedIndex = 0
    
    let tabBarImages = ["Athan","Athkar","Tasbih","Tasbih"]
 //   let tabBarLabel = ["أذان"]
    
    init(){
        UITabBar.appearance().isHidden = true;
    }
    
    var body: some View {
        
        ZStack(alignment:.bottom){
            TabView(selection: $selectedIndex){
                PrayersTimeView()
                    .tag(0)
                
                AthkarView()
                    .tag(1)
                
                Text("View 2")
                    .tag(2)
                
                
                Text("View 3")
                    .tag(3)
                
            }
            
            HStack{
                ForEach(0..<tabBarImages.count) { i in
                    Button(action:{
                        selectedIndex = i;
                    }){  Spacer()
                    TabIcon(label: tabBarImages[i], iconName: tabBarImages[i])
                            .foregroundColor((selectedIndex == i) ? .black : .gray)
                    Spacer()}
                }
            }
            .padding(.top,4)
            .background(.ultraThinMaterial)
            
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
                .font(.caption2)
        }
    }
}
