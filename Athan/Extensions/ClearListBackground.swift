//
//  ClearListBackground.swift
//  Athan
//
//  Created by Khalid Alhazmi on 20/01/2023.
//

import Foundation
import SwiftUI
struct ClearListBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
                .onAppear {
                }
        } else {
            content
//                .onAppear {
//                UITableView.appearance().backgroundColor = .clear
//                UITableView.appearance().showsVerticalScrollIndicator = false
//            }
        }
    }
}

extension View {
    func clearListBackground() -> some View {
        return modifier(ClearListBackgroundModifier())
    }
}
