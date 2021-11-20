//
//  LinkButton.swift
//  Athan
//
//  Created by Khalid Alhazmi on 17/10/2021.
//

import SwiftUI

struct LinkButton: View {
    let label: LocalizedStringKey
    let urlSring: String
    var body: some View {
        Button {
            guard let url = URL(string: urlSring) else { return }
            UIApplication.shared.open(url)
        } label: {
            HStack {
                Text(label)
                Spacer()
            }
        }
        .buttonStyle(.borderless)
    }
}
