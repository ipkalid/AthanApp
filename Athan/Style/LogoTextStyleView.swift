//
//  SwiftUIView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 24/09/2021.
//

import SwiftUI

struct LogoTextStyleView: View {
    let label: LocalizedStringKey
    let size: Double
    let color: Color
    let isArabic: Bool

    init(_ key: LocalizedStringKey, size: Double = 32, color: Color = Color("Yellow"), isArabic: Bool = false) {
        label = key
        self.size = size
        self.color = color
        if(isArabic == true){
            self.isArabic = isArabic
        }
        else{
            self.isArabic = Helper.isArabic()
        }
    }

    var body: some View {
        ZStack {
            Text(label)
                .offset(x: size / 25, y: size / 25)
                .opacity(0.4)
            Text(label)
        }
        .font(isArabic ? Font.custom("Rakkas-Regular", size: size) : Font.system(size: size - 6, weight: .semibold, design: .rounded))
        .foregroundColor(color)
    }
}
