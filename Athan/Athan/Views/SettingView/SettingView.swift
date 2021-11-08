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
    @ObservedObject var vm = SettingView.ViewModel()

    var body: some View {
        NavigationView {
            List {
                Group {
                    SettingLocationButton(
                        action: vm.requestLocation,
                        showIndicator: vm.showLoadingIndicator,
                        cityName: env.cityName
                    )
                    .alert(isPresented: $vm.showLocationDeniedAlert, content: LocationManager.showLocationDeniedAlert)

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

extension SettingView {
    class ViewModel: ObservableObject {
        let env = EnvViewModel.shared

        @Published var showLoadingIndicator: Bool = false
        @Published var showLocationDeniedAlert: Bool = false

        func requestLocation() {
            showLoadingIndicator = true
            env.requestLocation { location in
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.showLoadingIndicator = false
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
