//
//  SettingNotificationView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 16/10/2021.
//

import SwiftUI

struct SettingNotificationView: View {
    @State var morning: Bool = false
    @State var night: Bool = false
    @State var fajr: Bool = false
    @State var duhr: Bool = false
    @State var asr: Bool = false
    @State var magrib: Bool = false
    @State var isha: Bool = false
    var body: some View {
        List {
            Group {
                Section("إشعارات الأذكار") {
                    Toggle("أذكار الصباح", isOn: $morning)
                    Toggle("أذكار المساء", isOn: $night)
                }

                Section("الفجر") {
                    Toggle("أذان الفجر", isOn: $fajr.animation())
                    if fajr {
                        Text("بدون إشعار قبل الصلاة")
                        Text("٥ دقائق قبل الصلاة")
                        Text("١٠ دقيقة قبل الصلاة")
                        Text("٢٠ دقيقة قبل الصلاة")
                    }
                }

                Section("الظهر") {
                    Toggle("أذان الظهر", isOn: $duhr.animation())
                    if duhr {
                        Text("بدون إشعار قبل الصلاة")
                        Text("٥ دقائق قبل الصلاة")
                        Text("١٠ دقيقة قبل الصلاة")
                        Text("٢٠ دقيقة قبل الصلاة")
                    }
                }

                Section("العصر") {
                    Toggle("أذان العصر", isOn: $isha.animation())
                    if isha {
                        Text("بدون إشعار قبل الصلاة")
                        Text("٥ دقائق قبل الصلاة")
                        Text("١٠ دقيقة قبل الصلاة")
                        Text("٢٠ دقيقة قبل الصلاة")
                    }
                }

                Section("المغرب") {
                    Toggle("أذان المغرب", isOn: $asr.animation())
                    if asr {
                        Text("بدون إشعار قبل الصلاة")
                        Text("٥ دقائق قبل الصلاة")
                        Text("١٠ دقيقة قبل الصلاة")
                        Text("٢٠ دقيقة قبل الصلاة")
                    }
                }

                Section("العشاء") {
                    Toggle("أذان العشاء", isOn: $magrib.animation())
                    if magrib {
                        Text("بدون إشعار قبل الصلاة")
                        Text("٥ دقائق قبل الصلاة")
                        Text("١٠ دقيقة قبل الصلاة")
                        Text("٢٠ دقيقة قبل الصلاة")
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

struct SettingNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        SettingNotificationView()
    }
}
