//
//  SettingNotificationView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 16/10/2021.
//

import SwiftUI

struct SettingNotificationView: View {
    @EnvironmentObject var env: EnvViewModel
    @StateObject var vm = SettingNotificationViewModel()

    var body: some View {
        List {
            Group {
                Section("إشعارات الأذكار") {
                    Toggle("أذكار الصباح", isOn: $vm.morningAthkar)
                    Toggle("أذكار المساء", isOn: $vm.eveningAthkar)
                }

                Section("الفجر") {
                    Toggle("أذان الفجر", isOn: $vm.fajrNotification.animation())
                    if vm.fajrNotification {
                        Toggle("١٠ دقائق قبل الصلاة", isOn: $vm.beforeFajrNotification)
                    }
                }

                Section("الظهر") {
                    Toggle("أذان الظهر", isOn: $vm.dhuhrNotification.animation())
                    if vm.dhuhrNotification {
                        Toggle("١٠ دقائق قبل الصلاة", isOn: $vm.beforeDhuhrNotification)
                    }
                }

                Section("العصر") {
                    Toggle("أذان العصر", isOn: $vm.asrNotification.animation())
                    if vm.asrNotification {
                        Toggle("١٠ دقائق قبل الصلاة", isOn: $vm.beforeAsrNotification)
                    }
                }

                Section("المغرب") {
                    Toggle("أذان المغرب", isOn: $vm.maghribNotification.animation())
                    if vm.maghribNotification {
                        Toggle("١٠ دقائق قبل الصلاة", isOn: $vm.beforeMaghribNotification)
                    }
                }

                Section("العشاء") {
                    Toggle("أذان العشاء", isOn: $vm.ishaNotification.animation())
                    if vm.ishaNotification {
                        Toggle("١٠ دقائق قبل الصلاة", isOn: $vm.beforeIshaNotification)
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
                LogoTextStyleView("الإشعارات")
            }
        }
        .background(AppColors.SettingBackgroundColor.ignoresSafeArea())
    }
}

class SettingNotificationViewModel: ObservableObject {
    let env = EnvViewModel.shared
    static let shared = SettingNotificationViewModel()

    private func addNewNotification() {
        env.addNewPrayersNotification()
    }

    @AppStorage(UserDefaultsKey.morningAthkar) var morningAthkar: Bool = false {
        didSet {
            addNewNotification()
        }
    }

    @AppStorage(UserDefaultsKey.eveningAthkar) var eveningAthkar: Bool = false {
        didSet {
            addNewNotification()
        }
    }

    @AppStorage(UserDefaultsKey.fajrNotification) var fajrNotification: Bool = true {
        didSet {
            addNewNotification()
        }
    }

    @AppStorage(UserDefaultsKey.beforeFajrNotification) var beforeFajrNotification: Bool = false {
        didSet {
            addNewNotification()
        }
    }

    @AppStorage(UserDefaultsKey.dhuhrNotification) var dhuhrNotification: Bool = true {
        didSet {
            addNewNotification()
        }
    }

    @AppStorage(UserDefaultsKey.beforeDhuhrNotification) var beforeDhuhrNotification: Bool = false {
        didSet {
            addNewNotification()
        }
    }

    @AppStorage(UserDefaultsKey.asrNotification) var asrNotification: Bool = true {
        didSet {
            addNewNotification()
        }
    }

    @AppStorage(UserDefaultsKey.beforeAsrNotification) var beforeAsrNotification: Bool = false {
        didSet {
            addNewNotification()
        }
    }

    @AppStorage(UserDefaultsKey.maghribNotification) var maghribNotification: Bool = true {
        didSet {
            addNewNotification()
        }
    }

    @AppStorage(UserDefaultsKey.beforeMaghribNotification) var beforeMaghribNotification: Bool = false {
        didSet {
            addNewNotification()
        }
    }

    @AppStorage(UserDefaultsKey.ishaNotification) var ishaNotification: Bool = true {
        didSet {
            addNewNotification()
        }
    }

    @AppStorage(UserDefaultsKey.beforeIshaNotification) var beforeIshaNotification: Bool = false {
        didSet {
            addNewNotification()
        }
    }
}
