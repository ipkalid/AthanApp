//
//  SettingView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 12/10/2021.
//

import SwiftUI

struct SettingView: View {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableView.appearance().showsVerticalScrollIndicator = false
    }

    @EnvironmentObject var env: EnvViewModel

    var body: some View {
        NavigationView {
            List {
                Button(action: env.requestLocation) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("تحديث الموقع")
                            Spacer().frame(height: 5)
                            Text(env.cityName ?? "فعل الموقع أولا")
                                .font(.caption2)
                        }
                        Spacer()
                        env.showLocationIndicator
                            ? AnyView(ProgressView())
                            : AnyView(Image(systemName: "location.fill"))
                    }
                }
                .buttonStyle(.borderless)
                .disabled(env.showLocationIndicator)
                .listRowBackground(AppColors.SettinglistRowBackground)

                AppDetailsSection()

                DevloperDetailsSection()

                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        Text("Athan v\(appVersion!) ")
                    }
                    Spacer()
                }
                // .frame(width: UIScreen.screenWidth)
                .listRowBackground(Color.clear)
            }
            .foregroundColor(.white)
            .listStyle(.insetGrouped)
            .padding(.top, 1)
            .navigationTitle("الإعدادات")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    LogoTextStyleView("الإعدادات")
                }
            }
            .background(AppColors.SettingBackgroundColor.ignoresSafeArea())
        }
        .modifier(GoToSettingAlert(isPresented: $env.showGoToSettingAlert))
        .accentColor(AppColors.yellow)
    }
}
