//
//  AppSettingSection.swift
//  Athan
//
//  Created by Khalid Alhazmi on 16/10/2021.
//

import SwiftUI

struct AppSettingSection: View {
    @EnvironmentObject var env: EnvViewModel

    var body: some View {
        Section(header: Text("Athan Settings")) {
            NavigationLink {
                SettingNotificationView()
            } label: {
                HStack {
                    Text("Notifications")
                    Spacer()
                }
            }

            NavigationLink {
                SettingSoundView()
            } label: {
                HStack {
                    Text("Athan's Sound")
                    Spacer()
                }
            }

            Button(action: Helper.goToAppSetting) {
                HStack {
                    Text("Change Language")
                    Spacer()
                }
            }
        }
        .environmentObject(env)
        .buttonStyle(.borderless)
    }
}

//
//            Button(action: {
// showSheet = true
// sheetTitle = "الحساب الفقهي لصلاة العصر"
//
// let action1 = ("أم القرى", {
//    env.calculationMethod = .ummAlQura
// })
//
// let action2 = ("رابطة العالم الإسلامي", {
//    env.calculationMethod = .muslimWorldLeague
// })
//
// let action3 = ("دبي", {
//    env.calculationMethod = .dubai
// })
// let action4 = ("الكويت", {
//    env.calculationMethod = .kuwait
// })
// let action5 = ("قطر", {
//    env.calculationMethod = .qatar
// })
//
// actions = Actions([action1, action2, action3, action4, action5])
// }) {
// VStack(alignment: .leading) {
//    Text("نوع التقويم")
//    Spacer().frame(height: 5)
//    Text(env.getCalculationMethod())
//        .font(.caption2)
// }.multilineTextAlignment(.leading)
// }
//
// Button(action: {
// showSheet = true
// sheetTitle = "الحساب الفقهي لصلاة العصر"
//
// let action1 = ("حنفي", {
//    env.madhabType = .hanafi
// })
// let action2 = ("حنبلي - مالكي - شافعي", {
//    env.madhabType = .shafi
// })
//
// actions = Actions([action1, action2])
// }) {
// VStack(alignment: .leading) {
//    Text("الحساب الفقهي للصلاة")
//    Spacer().frame(height: 5)
//    Text(env.getMadhabName())
//        .font(.caption2)
// }.multilineTextAlignment(.leading)
// }
// .confirmationDialog(sheetTitle, isPresented: $showSheet, titleVisibility: .visible, actions: { actions })
// struct Actions: View {
// var actions: [(title: String, action: () -> Void)] = []
// init(_ actions: [(title: String, action: () -> Void)]) {
//    self.actions = actions
// }
//
// var body: some View {
//    ForEach(actions.indices, id: \.self) { i in
//        Button(actions[i].title, action: actions[i].action)
//    }
// }
// }
