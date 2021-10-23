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
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                PrayerTimeHeader()

                if let prayers = env.prayers {
                    PrayerTimeCard(prayers: prayers)
                        .padding()

                } else {
                    VStack {
                        Text("الرجاء الضغط على الأيقونة لتفعيل الموقع")
                            .font(.title)
                            .multilineTextAlignment(.center)

                        Button(action: env.requestLocation) {
                            if env.showLocationIndicator {
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
                        .disabled(env.showLocationIndicator)
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
                    LogoTextStyleView(env.cityName ?? "أوقات الصلاة")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .modifier(GoToSettingAlert(isPresented: $env.showGoToSettingAlert))
        }
    }
}
