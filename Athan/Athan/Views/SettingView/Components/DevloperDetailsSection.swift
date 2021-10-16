//
//  DevloperSection.swift
//  Athan
//
//  Created by Khalid Alhazmi on 16/10/2021.
//

import Foundation
import SwiftUI

struct DevloperDetailsSection: View {
    
    var body:some View{
        Section(header: Text("المطور")) {
            Button("تابع المطور على Twitter"){
                guard let url = URL(string: "https://twitter.com/iKAlhazmi") else { return }
                UIApplication.shared.open(url)
            }
            Button("تابع المطور على Linkden"){
                guard let url = URL(string: "https://www.linkedin.com/in/khalid-alhazmi") else { return }
                UIApplication.shared.open(url)
            }
            Button("تابع المطور على GitHub"){
                guard let url = URL(string: "https://Github.com/ipkalid") else { return }
                UIApplication.shared.open(url)
            }
            Button("إدعم المطور"){
                guard let url = URL(string: "https://www.buymeacoffee.com/iKhalid") else { return }
                UIApplication.shared.open(url)
            }
        }
        .listRowSeparatorTint(.white.opacity(0.3))
        .listRowBackground(AppColors.SettinglistRowBackground)
    }
}
