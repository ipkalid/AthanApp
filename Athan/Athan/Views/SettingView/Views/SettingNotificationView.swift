//
//  SettingNotificationView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 16/10/2021.
//

import SwiftUI

struct SettingNotificationView: View {
    var body: some View {
        List {
            Text("TEXT")
            Text("TEXT")
            Text("TEXT")
            Text("TEXT")
        }
        .padding(.top, 1)
        .toolbar {
            ToolbarItem(placement: .principal) {
                NavigationTitleText("الإشعارات")
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
