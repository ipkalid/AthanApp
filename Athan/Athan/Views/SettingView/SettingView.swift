//
//  SettingView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 12/10/2021.
//

import SwiftUI

struct SettingView: View {
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableView.appearance().showsVerticalScrollIndicator = false
    }

    @EnvironmentObject var env: EnvViewModel
    @State var showLoadingIndicator: Bool = false
    @State var showLocationDeniedAlert: Bool = false

    var body: some View {
        NavigationView {
            List {
                Group {
                    SettingLocationButton(
                        action: {
                            env.requestLocation { location in
                                let latitude = location.coordinate.latitude
                                let longitude = location.coordinate.longitude
                                showLoadingIndicator = true
                                DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                                    showLoadingIndicator = false
                                    env.updateLocation(latitude: latitude, longitude: longitude)
                                }

                            } completionHandler: { authorizationStatus in
                                switch authorizationStatus {
                                case .denied:
                                    self.showLocationDeniedAlert = true
                                default:
                                    return
                                }
                            }
                        },
                        showIndicator: showLoadingIndicator,
                        cityName: env.cityName
                    )
                    .alert(isPresented: $showLocationDeniedAlert, content: LocationManager.showLocationDeniedAlert)

                    // AppSettingSection()

                    AppDetailsSection()

                    DevloperDetailsSection()

                    AppVersion()
                }
                .listRowSeparatorTint(.white.opacity(0.3))
                .listRowBackground(AppColors.SettinglistRowBackground)
            }
            .foregroundColor(.white)
            .listStyle(.insetGrouped)
            .padding(.top, 1)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    LogoTextStyleView("Settings")
                }
            }
            .background(AppColors.SettingBackgroundColor.ignoresSafeArea())
        }
        .accentColor(AppColors.yellow)
    }

    private func AppVersion() -> some View {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return HStack {
            Spacer()
            Text("Athan v\(appVersion!) ")
            Spacer()
        }
        .listRowBackground(Color.clear)
    }
}

extension SettingView{
    class ViewModel:ObservableObject{
        let env = EnvViewModel.shared
        
        @State var showLoadingIndicator: Bool = false
        @State var showLocationDeniedAlert: Bool = false
    }
}
