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
            
            Button("تابع التطبيق على Twitter"){
                guard let url = URL(string: "https://twitter.com/iKAlhazmi") else { return }
                UIApplication.shared.open(url)
            }
            Button("قيم التطبيق ⭐️⭐️⭐️⭐️⭐️"){
                guard let url = URL(string: "https://www.linkedin.com/in/khalid-alhazmi/") else { return }
                UIApplication.shared.open(url)
            }
            Button("راسلني حول التطبيق"){
                guard let url = URL(string: "https://www.buymeacoffee.com/iKhalid") else { return }
                UIApplication.shared.open(url)
            }
            
        }
        .listRowSeparatorTint(.white.opacity(0.3))
        .listRowBackground(AppColors.SettinglistRowBackground)
    }
}
