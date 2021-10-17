//
//  AppDetailsSection.swift
//  Athan
//
//  Created by Khalid Alhazmi on 16/10/2021.
//

import SwiftUI

struct AppDetailsSection: View {
    var body: some View {
        Section(header: Text("أذان")) {
            LinkButton(label: "تابع التطبيق على Twitter", urlSring: "https://twitter.com/iKAlhazmi")
            LinkButton(label: "قيم التطبيق ⭐️⭐️⭐️⭐️⭐️", urlSring: " ")
            LinkButton(label: "راسلني حول التطبيق", urlSring: "https://twitter.com/iKAlhazmi")
        }
        .listRowSeparatorTint(.white.opacity(0.3))
        .listRowBackground(AppColors.SettinglistRowBackground)
    }
}
