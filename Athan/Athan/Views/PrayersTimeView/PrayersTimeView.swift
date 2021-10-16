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
            
            ScrollView(){
                HStack(alignment:.center) {
                    
                    Text(viewModel.getHijriDate())
                        .frame(width: 100)
                        .padding(.vertical,8)
                        .background(.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Spacer()
                    
                    Text(viewModel.getDayInWeek())
                        .font(.title2)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.4)
                        .foregroundColor(AppColors.yellow)
                        .shadow(radius: 6)
                    
                    
                    Spacer()
                    
                    Text(viewModel.getDate())
                        .frame(width: 100)
                        .padding(.vertical,8)
                        .background(.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    
                    
                    
                }
                .padding(.horizontal,32)
                .padding(.top,30)
                
                
                PrayerTimeCard(prayers: viewModel.prayers)
                    .padding()
                
                Text("لا توجل عمل اليوم الى الغد لأنك سوف تندم ندما")
                    //.font(Font.custom("me_quran", size: 32))
                    .font(.title)
                    .minimumScaleFactor(0.4)
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppColors.yellow)
                    .shadow(radius: 6)
               Spacer()
            }
            .padding(.top,1)
            .background( AppColors.backgroundColor.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    NavigationTitleText("أوقات الصلاة")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    viewModel.isGettingLocation
                    ? AnyView(ProgressView())
                    : AnyView(
                        Button(action: viewModel.requestLocation,
                               label: {Image(systemName: "location.fill")
                                       .tint(AppColors.yellow)
                               }
                              )
                    )
                    
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
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
        
        var locationManager =  LocstionManager();
        private var today = Date.now
        
        
        init() {
            let cal = Calendar(identifier: Calendar.Identifier.gregorian)
            let date = cal.dateComponents([.year, .month, .day], from: today)
            let coordinates = Coordinates(latitude: 24.797761, longitude: 46.741433)
            let params = CalculationMethod.ummAlQura.params
            
            guard let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) else{ return}
            self.prayers = prayers;
            
            print(prayers)
//            if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
//                self.prayers = prayers;
//            }
            
        }
        
        func getDate() -> String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY/MM/dd"
            return  dateFormatter.string(from: today)
            
        }
        
        func getDayInWeek() -> String{
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.init(identifier: "ar")
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: today)
        }
        
        func getHijriDate() -> String{
            let dateFormatter = DateFormatter()

            let hijriCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
            dateFormatter.locale = Locale.init(identifier: "ar")
            dateFormatter.calendar = hijriCalendar
            dateFormatter.dateFormat = "yyyy/MM/dd"

           
            return dateFormatter.string(from: today)
        }
        
        
        func requestLocation(){
            isGettingLocation = true;
            locationManager.getLocation()
            
            isGettingLocation = false

            
            
        }
    }
    
}

struct PrayerItmeView_Previews: PreviewProvider {
    static var previews: some View {
        PrayersTimeView()
    }
}
