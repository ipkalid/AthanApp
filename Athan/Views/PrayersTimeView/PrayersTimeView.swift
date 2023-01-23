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
    @StateObject var vm = PrayersTimeView.ViewModel()
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                PrayerTimeHeader()

                if let prayers = env.prayers {
                    VStack(spacing: 4) {
                        VStack {
                            if let nextPrayerName = vm.nextPrayer?.prayerName {
                                if Helper.isArabic() {
                                    HStack {
                                        Text("صلاة")
                                        Text(nextPrayerName)
//                                            .bold()
                                        Text("بعد")
                                    }
                                    .font(.title)

                                } else {
                                    HStack {
                                        Text(nextPrayerName)
                                        Text("Prayer After")
                                    }
                                    .font(.title)
                                }
                            }

                            Text(vm.nextPrayerCountDown)
                                .font(.system(.largeTitle, design: .monospaced))
                                .fontWeight(.semibold)
                                .onReceive(vm.timer, perform: { _ in
                                    vm.currentTime = Date.now
                                })

                        }.multilineTextAlignment(.center)
                            .foregroundColor(AppColors.yellow)
                            .shadow(radius: 6)
                        PrayerTimeCard(prayers: prayers)
                            .padding(.horizontal)
                            .environmentObject(env)
                    }

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
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

        @Published var showLocationIndicator: Bool = false
        @Published var showLocationDeniedAlert: Bool = false
        @Published var currentTime = Date.now

        var nextPrayerCountDown: String {
            guard let prayers = env.prayers else { return "ERROR" }
            var nextPrayerDate: Date
            if let nextPrayer = prayers.nextPrayer() {
                nextPrayerDate = prayers.time(for: nextPrayer)
            } else {
                nextPrayerDate = prayers.fajr.addingTimeInterval(60 * 60 * 24)
            }

            let calendar = Calendar(identifier: .gregorian)

            let components = calendar
                .dateComponents([.hour, .minute, .second],
                                from: currentTime,
                                to: nextPrayerDate
                )

            return String(format: "%02d:%02d:%02d",
                          components.hour ?? 00,
                          components.minute ?? 00,
                          components.second ?? 00
            )
        }

        var nextPrayer: Adhan.Prayer? {
            guard let prayers = env.prayers else { return nil }
            return prayers.nextPrayer() ?? prayers.currentPrayer(at: prayers.fajr)
        }

        func requestLocation() {
            showLocationIndicator = true
            env.requestLocation { location in
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
