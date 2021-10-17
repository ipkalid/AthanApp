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
    }

    var body: some View {
        NavigationView {
            List {
                Button(action: {}) { HStack {
                    VStack(alignment: .leading) {
                        Text("تحديث الموقع")
                        Spacer().frame(height: 5)
                        Text("الرياض")
                            .font(.caption2)
                    }

                    Spacer()
                    Image(systemName: "location.fill")
                }
                .multilineTextAlignment(.leading)
                }
                .listRowBackground(AppColors.SettinglistRowBackground)

                AppSettingSection()

                AppDetailsSection()

                DevloperDetailsSection()
            }
            .foregroundColor(.white)
            .listStyle(.insetGrouped)
            .padding(.top, 1)
            .navigationTitle("الإعدادات")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    NavigationTitleText("الإعدادات")
                }
            }
            .background(AppColors.SettingBackgroundColor.ignoresSafeArea())
        }
        .accentColor(AppColors.yellow)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
