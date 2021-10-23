//
//  DevloperSection.swift
//  Athan
//
//  Created by Khalid Alhazmi on 16/10/2021.
//

import Foundation
import SwiftUI

struct DevloperDetailsSection: View {
    var body: some View {
        Section(header: Text("المطور")) {
            LinkButton(label: "تابع المطور على Twitter", urlSring: "https://twitter.com/iKalidDev")
            LinkButton(label: "تابع المطور على Linkden", urlSring: "https://www.linkedin.com/in/khalid-alhazmi")
            LinkButton(label: "تابع المطور على GitHub", urlSring: "https://Github.com/ipkalid")
            //LinkButton(label: "إدعم المطور", urlSring: "https://www.buymeacoffee.com/iKhalid")
        }
        .listRowSeparatorTint(.white.opacity(0.3))
        .listRowBackground(AppColors.SettinglistRowBackground)
    }
}
