//
//  ContentView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import SwiftUI

let backgroundColor = LinearGradient(gradient: Gradient(colors: [Color(hex: "0081A7"), Color(hex: "00AFB9")]),startPoint: .top,endPoint: .bottom)

struct ContentView: View {
    var body: some View {
        
        TabView(){
            HomeView()
                .tabItem {  Label("Athan", systemImage: "seal.fill")}
            
            Text("View 2")
                .tabItem { Label("Athkar", systemImage: "diamond.fill") }
            
            Text("View 2")
                .tabItem {Label("Athkar", systemImage: "50.circle.fill")}
            
            
            Text("View 2")
                .tabItem { Label("Setting", systemImage: "gear")}
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PrayerTimeView: View {
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text("Fajr")
                    .font(.title2)
                Text("05:45 am")
                    .font(.callout)
                    .foregroundColor(.secondary)
                
            }
            Spacer()
            
            Image(systemName: "sunrise")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            
            
        }
        .padding(8.0)
        
    }
}

struct PrayerTimeList: View {
    var body: some View {
        VStack(spacing:0){
            PrayerTimeView()
            Divider()
            PrayerTimeView()
            Divider()
            PrayerTimeView()
            Divider()
            PrayerTimeView()
            Divider()
            PrayerTimeView()
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(8)
        .shadow(radius: 10)
        .padding()
    }
}

struct HomeView: View {
    var body: some View {
        ZStack{
            
            backgroundColor
                .ignoresSafeArea()
            
            
            VStack{
                
                VStack(alignment:.leading){
                    HStack {
                        Text("Riyadh")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                        
                        Image(systemName: "location.fill")
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                    
                    Text("\(Date().description)")
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                }.padding([.horizontal],8)
                
                
                PrayerTimeList()
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas cursus")
                    .font(.title3)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
            }
            
        }
        
        .navigationBarHidden(true)
    }
}
