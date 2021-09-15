//
//  ContentView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import SwiftUI
import Adhan

let backgroundColor = LinearGradient(gradient: Gradient(colors: [Color(hex: "0081A7"), Color(hex: "00AFB9")]),startPoint: .top,endPoint: .bottom)

struct AppTappedView: View {
    
    
    
    init() {
       // UITabBar.appearance().backgroundColor = UIColor.clear
       // UITabBar.appearance().backgroundImage = UIImage()
        //UITabBar.appearance().barTintColor = .white
        //  UITabBar.appearance().unselectedItemTintColor = .yellow
       //UITabBar.appearance().barTintColor = .black
//
//        UITabBar.appearance().barTintColor = .black
//        UITabBar.appearance().tintColor = .blue
//        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
//        UITabBar.appearance().clipsToBounds = true
    }
var body: some View {

        
        TabView(){
            AthanView()
                .accentColor(.none)
                .tabItem {Label("Athan", systemImage: "seal.fill")}
            
            AthkarView()
                .accentColor(.none)
                .tabItem {Label("Athkar", systemImage: "diamond.fill")}
            
            Text("View 2")
                .accentColor(.none)
                .navigationTitle("Riyadh")
                .navigationBarTitleDisplayMode(.inline)
                
                .tabItem {Label("Athkar", systemImage: "50.circle.fill")}
            
            
            Text("View 2")
                .accentColor(.none)
                .tabItem { Label("Setting", systemImage: "gear")}
        }

    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTappedView()
    }
}




//.onAppear(perform: {
//    let cal = Calendar(identifier: Calendar.Identifier.gregorian)
//    let date = cal.dateComponents([.year, .month, .day], from: Date())
//    let coordinates = Coordinates(latitude: 35.78056, longitude: -78.6389)
//    var params = CalculationMethod.muslimWorldLeague.params
//    params.madhab = .hanafi
//    if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .medium
//        formatter.timeZone = TimeZone(identifier: "America/New_York")!
//
//        NSLog("fajr %@", formatter.string(from: prayers.fajr))
//        NSLog("sunrise %@", formatter.string(from: prayers.sunrise))
//        NSLog("dhuhr %@", formatter.string(from: prayers.dhuhr))
//        NSLog("asr %@", formatter.string(from: prayers.asr))
//        NSLog("maghrib %@", formatter.string(from: prayers.maghrib))
//        NSLog("isha %@", formatter.string(from: prayers.isha))
//    }
//})
