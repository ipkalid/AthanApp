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

    init(_ key: LocalizedStringKey, size: Double = 32, color: Color = Color("Yellow")) {
        label = key
        self.size = size
        self.color = color
    }

    var body: some View {
        ZStack {
            Text(label)
                .offset(x: size / 25, y: size / 25)
                .opacity(0.4)
            Text(label)
        }
        .font(Helper.isArabic() ? Font.custom("Rakkas-Regular", size: size) : Font.system(size: size, weight: .semibold, design: .rounded))
        .foregroundColor(color)
    }
}
