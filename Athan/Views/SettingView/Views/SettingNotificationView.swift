//
//  SettingNotificationView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 16/10/2021.
//

import SwiftUI

struct SettingNotificationView: View {
    @EnvironmentObject var env: EnvViewModel

    var body: some View {
        List {
            Group {
                Section(header: Text("Athkar Notifications")) {
                    Toggle("Morning Athkar Reminder", isOn: $env.morningAthkar)
                    Toggle("Evening Athkar Reminder", isOn: $env.eveningAthkar)
                }

                Section(header: Text("Fajr")) {
                    Toggle("Prayer Time Reminder", isOn: $env.fajrNotification.animation())
                    if env.fajrNotification {
                        Toggle("10 Minutes Brefore Prayer Time Reminder", isOn: $env.beforeFajrNotification)
                    }
                }

                Section(header: Text("Dhuhr")) {
                    Toggle("Prayer Time Reminder", isOn: $env.dhuhrNotification.animation())
                    if env.dhuhrNotification {
                        Toggle("10 Minutes Brefore Prayer Time Reminder", isOn: $env.beforeDhuhrNotification)
                    }
                }

                Section(header: Text("Asr")) {
                    Toggle("Prayer Time Reminder", isOn: $env.asrNotification.animation())
                    if env.asrNotification {
                        Toggle("10 Minutes Brefore Prayer Time Reminder", isOn: $env.beforeAsrNotification)
                    }
                }

                Section(header: Text("Maghrib")) {
                    Toggle("Prayer Time Reminder", isOn: $env.maghribNotification.animation())
                    if env.maghribNotification {
                        Toggle("10 Minutes Brefore Prayer Time Reminder", isOn: $env.beforeMaghribNotification)
                    }
                }

                Section(header: Text("Isha")) {
                    Toggle("Prayer Time Reminder", isOn: $env.ishaNotification.animation())
                    if env.ishaNotification {
                        Toggle("10 Minutes Brefore Prayer Time Reminder", isOn: $env.beforeIshaNotification)
                    }
                }
            }
            .listRowSeparatorTint(.white.opacity(0.3))
            .listRowBackground(AppColors.SettinglistRowBackground)
        }
        .foregroundColor(.white)
        .padding(.top, 1)
        .navigationTitle("Notifications")
        .toolbar {
            ToolbarItem(placement: .principal) {
                LogoTextStyleView("Notifications")
            }
        }
        .background(AppColors.SettingBackgroundColor.ignoresSafeArea())
    }
}
