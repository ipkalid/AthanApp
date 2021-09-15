//
//  PrayerTimeView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import Foundation
import SwiftUI


struct PrayerItmeView: View {
    @State private var isGettingLocation:Bool = false;
    @StateObject var locationManager = LocationManager();
    @State private var cityName:String = "";
    var body: some View {
        ZStack{
            
            backgroundColor
                .ignoresSafeArea()
            VStack{
                
                
                PrayerTimeCard()
                
                Text(cityName)
                    .font(.title3)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
        }
        .navigationBarItems( trailing: Button(action: {
            isGettingLocation.toggle()
            locationManager.requestLocation();
            cityName = locationManager.location?.longitude.description ?? ""
        } ){
            !isGettingLocation ? AnyView(Image(systemName: "location.fill")): AnyView(ProgressView()
            )        }.foregroundColor(Color("Yellow"))
        )
    }
}

struct PrayerItmeView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerItmeView()
    }
}
