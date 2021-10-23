//
//  Modifires.swift
//  Athan
//
//  Created by Khalid Alhazmi on 22/10/2021.
//

import SwiftUI

struct MainCardStyle: ViewModifier {
    let height: CGFloat?
    init(height: CGFloat? = nil) {
        self.height = height
    }

    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.screenWidth * 0.8, height: height)
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(8)
            .shadow(radius: 10)
    }
}


struct GoToSettingAlert: ViewModifier {
    @Binding var isPresented:Bool

    func body(content: Content) -> some View {
        content
            .alert("تفعيل الموقع", isPresented: $isPresented) {
                Button("الذهاب الى الإعدادات") {
                    Helper.goToAppSetting();
                }
                Button("إلغاء",role: .cancel) {
                }
            } message: {
                Text("الرجاء تفعيل الموقع من الإعدادات")
            }
    }
}

