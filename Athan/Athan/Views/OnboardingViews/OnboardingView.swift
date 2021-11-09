//
//  OnboardingView.swift
//  Athan
//
//  Created by Kalid on 29/10/2021.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var env: EnvViewModel
    @StateObject var vm = OnboardingView.ViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                AppColors.backgroundColor.ignoresSafeArea()
                TabView(selection: $vm.selectedTab) {
                    OnBordingCardView(
                        title: "Press the Icon to Activate the Location",
                        iconButtom: {
                            Button(action: vm.requestLocation) {
                                Image(systemName: vm.isLocationAuthrised ? "checkmark" : "location.fill")
                                    .foregroundColor(vm.isLocationAuthrised ? .green : .black)

                            }.disabled(vm.showLocationLoadingIndicator)
                        }
                    )
                    .alert(isPresented: $vm.showLocationDeniedAlert) {
                        LocationManager.showLocationDeniedAlert()
                    }
                    .tag(0)

                    OnBordingCardView(
                        title: "Press the Icon to Activate the Notifications",
                        iconButtom: {
                            Button(action: vm.requestNotification) {
                                Image(systemName: vm.isNotificationAuthrised ? "checkmark" : "bell.badge.fill")
                                    .foregroundColor(vm.isNotificationAuthrised ? .green : .black)
                            }
                        }
                    )
                    .alert(isPresented: $vm.showNotificationDeniedAlert) {
                        NotificationManager.showNotificationDeniedAlert()
                    }
                    .tag(1)

                    OnBordingCardView(
                        title: "Press the Icon to Enter the App",
                        frameSize: 120,
                        iconButtom: {
                            Button(action: vm.goToMainApp) {
                                VStack {
                                    NavigationLink(destination: AppTapView(), isActive: $vm.showMainApp) { EmptyView() }

                                    LogoTextStyleView("أذان", size: 64, color: .black)
                                }
                            }
                        }
                    )
                    .tag(2)
                }
                .tabViewStyle(.page)
            }
            .navigationBarHidden(true)
        }
    }
}

extension OnboardingView {
    class ViewModel: ObservableObject {
        let env: EnvViewModel = EnvViewModel.shared
        @Published var isNotificationAuthrised: Bool = false
        @Published var showNotificationDeniedAlert: Bool = false

        @Published var isLocationAuthrised: Bool = false
        @Published var showLocationLoadingIndicator: Bool = false
        @Published var showLocationDeniedAlert: Bool = false

        @Published var showMainApp: Bool = false

        @Published var selectedTab = 0

        func goToMainApp() {
            showMainApp = true
            env.showOnboarding = false
        }

        func requestLocation() {
            env.requestLocation { location in
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                self.env.updateLocation(latitude: latitude, longitude: longitude)
                self.isLocationAuthrised = true
                withAnimation {
                    self.selectedTab = 1
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

        func requestNotification() {
            env.requestNotification { onSucess, error, authorizationStatus in
                if let error = error {
                    debugPrint("Error: " + error.localizedDescription)
                    return
                }
                switch authorizationStatus {
                case .notDetermined:
                    if onSucess {
                        DispatchQueue.main.async {
                            self.isNotificationAuthrised = true
                            withAnimation { self.selectedTab = 2 }
                        }
                    }
                case .authorized:
                    DispatchQueue.main.async {
                        self.isNotificationAuthrised = true
                    }
                case .denied:
                    DispatchQueue.main.async {
                        self.showNotificationDeniedAlert = true
                    }
                default:
                    return
                }
            }
        }
    }
}
