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

            .navigationBarTitle(viewModel.cityName ?? "Athan" )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: viewModel.isGettingLocation ? AnyView(ProgressView()) : AnyView(Button(action: {
                viewModel.getLocationAndUpdatePrayerstime();
            }, label: {
                Image(systemName: "location.fill")
                    .accentColor(Color("Yellow"))
            })))
            
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text("You Need to "), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
            }
        }
    }
}

extension PrayersTimeView{
    final class ViewModel: ObservableObject {
        @Published var prayers:PrayerTimes?
        @Published var cityName:String?
        @Published var isGettingLocation:Bool = false;
        @Published var showingAlert = false
        
        var locationManager =  LocationManager()

        
        
        init() {
            let cal = Calendar(identifier: Calendar.Identifier.gregorian)
            let date = cal.dateComponents([.year, .month, .day], from: Date())
            let coordinates = Coordinates(latitude: 24.797761, longitude: 46.741433)
            let params = CalculationMethod.ummAlQura.params
            
            
            if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
                self.prayers = prayers;
            }
        }
        
        
        func getLocationAndUpdatePrayerstime(){
            isGettingLocation = true;
                        
            locationManager.checkIfLocationManagerEnabled()
            
            
        }
    }
    
}

struct PrayerItmeView_Previews: PreviewProvider {
    static var previews: some View {
        PrayersTimeView()
    }
}
