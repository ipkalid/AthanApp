//
//  PrayerTimeView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import Foundation
import SwiftUI
import Adhan


struct PrayersTimeView: View {
    @ObservedObject var viewModel = PrayersTimeView.ViewModel()


    var body: some View {
        NavigationView{
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                VStack{
                    PrayerTimeCard(prayers: viewModel.prayers)
                    Spacer()
                }
            }
            .navigationBarTitle(viewModel.cityName )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems( trailing: Button(action: {
                viewModel.isGettingLocation.toggle()
                viewModel.getNewPrayersTime();
                
            } ){
                !viewModel.isGettingLocation ? AnyView(Image(systemName: "location.fill")): AnyView(ProgressView()
                )        }.foregroundColor(Color("Yellow"))
            )}
    }
}

extension PrayersTimeView{
    class ViewModel: ObservableObject {
        @Published var prayers:PrayerTimes?
        @Published var cityName:String = "Athan"
        @Published  var isGettingLocation:Bool = false;
        
        
        
        init() {
            let cal = Calendar(identifier: Calendar.Identifier.gregorian)
            let date = cal.dateComponents([.year, .month, .day], from: Date())
            let coordinates = Coordinates(latitude: 24.797761, longitude: 46.741433)
            let params = CalculationMethod.ummAlQura.params
            
            
            if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
                self.prayers = prayers;
            }
        }
        
        let locationManager =  LocationManager()
        
        
        func getNewPrayersTime(){
            locationManager.requestLocation();
            cityName = locationManager.cityName ?? "Athan"
            let cal = Calendar(identifier: Calendar.Identifier.gregorian)
            let date = cal.dateComponents([.year, .month, .day], from: Date())
            let coordinates = Coordinates(latitude: locationManager.location!.latitude, longitude: locationManager.location!.longitude)
            let params = CalculationMethod.ummAlQura.params
            if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
                self.prayers = prayers;
            }
        }
    }
    
}

struct PrayerItmeView_Previews: PreviewProvider {
    static var previews: some View {
        PrayersTimeView()
    }
}
