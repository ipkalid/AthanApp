//
//  AppDetailsSection.swift
//  Athan
//
//  Created by Khalid Alhazmi on 16/10/2021.
//

import SwiftUI

struct AppDetailsSection: View {
    var body: some View {
        Section(header: Text("Athan")) {
            LinkButton(label: "Follow Athan on Twitter", urlSring: "https://twitter.com/AthanDevSA")
            LinkButton(label: "Rate the app ⭐️⭐️⭐️⭐️⭐️", urlSring: "https://apps.apple.com/app/id1592984010?action=write-review")
            LinkButton(label: "Message me about the app", urlSring: "https://twitter.com/iKAlhazmi")
        }
    }
}
