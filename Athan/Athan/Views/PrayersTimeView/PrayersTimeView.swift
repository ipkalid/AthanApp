//
//  PrayerTimeView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import Adhan
import CoreLocation
import Foundation
import SwiftUI

struct PrayersTimeView: View {
    @EnvironmentObject var env: EnvViewModel
    @ObservedObject var vm = PrayersTimeView.ViewModel()

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                PrayerTimeHeader()

                if let prayers = env.prayers {
                    PrayerTimeCard(prayers: prayers)
                        .padding()

                } else {
                    VStack {
                        Text("Press the Icon to Activate the Location")
                            .font(.title)
                            .multilineTextAlignment(.center)

                        Button(action: vm.requestLocation) {
                            if vm.showLocationIndicator {
                                ProgressView()
                            } else {
                                Image(systemName: "location.fill")
                            }
                        }
                        .padding()
                        .frame(width: 70, height: 70, alignment: .center)
                        .background(
                            Circle()
                                .stroke(.black, lineWidth: 2)
                        )
                        .disabled(vm.showLocationIndicator)
                    }
                    .font(.largeTitle)
                    .modifier(MainCardStyle(height: 300))
                    .padding()
                }
//
//                Text("لا توجل عمل اليوم الى الغد لأنك سوف تندم ندما")
//                    // .font(Font.custom("me_quran", size: 32))
//                    .font(.title)
//                    .minimumScaleFactor(0.4)
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(AppColors.yellow)
//                    .shadow(radius: 6)
                Spacer()
            }
            .padding(.top, 1)
            .background(AppColors.backgroundColor.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    if let cityName = env.cityName {
                        LogoTextStyleView("\(cityName)")
                    } else {
                        LogoTextStyleView("Prayer Time")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension PrayersTimeView {
    class ViewModel: ObservableObject {
        let env: EnvViewModel = EnvViewModel.shared
        @Published var showLocationIndicator: Bool = false
        @Published var showLocationDeniedAlert: Bool = false

        func requestLocation() {
            env.requestLocation { location in
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                self.showLocationIndicator = true
                DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                    self.showLocationIndicator = false
                    self.env.updateLocation(latitude: latitude, longitude: longitude)
                }
            } completionHandler: { authorizationStatus in
                switch authorizationStatus {
                case .denied:
                    self.showLocationDeniedAlert = true
                default:
                    return
                }
            }
        }
    }
}
