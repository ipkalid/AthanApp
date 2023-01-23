//
//  Modifires.swift
//  Athan
//
//  Created by Khalid Alhazmi on 22/10/2021.
//

import SwiftUI

struct MainCardStyle: ViewModifier {
    let height: CGFloat?
    let withPadding: Bool
    init(height: CGFloat? = nil, withPadding: Bool = true) {
        self.height = height
        self.withPadding = withPadding
    }

    func body(content: Content) -> some View {
        content
            .frame(width: withPadding ? UIScreen.screenWidth * 0.8 : UIScreen.screenWidth * 0.9, height: height)
            .padding(.vertical, withPadding ? nil : 0)
            .padding(.horizontal, withPadding ? nil : 0)
            .background(Color.white.opacity(0.8))
            .cornerRadius(8)
            .shadow(radius: 10)
    }
}

extension View {
    func mainCardView(height: CGFloat? = nil, withPadding: Bool = true) -> some View {
        modifier(MainCardStyle(height: height, withPadding: withPadding))
    }
}
