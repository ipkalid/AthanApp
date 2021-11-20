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
        Section(header: Text("Developer")) {
            LinkButton(label:"Follow the Developer on Twitter", urlSring: "https://twitter.com/iKAlhazmi")
            LinkButton(label: "Follow the Developer on Linkden", urlSring: "https://www.linkedin.com/in/khalid-alhazmi")
            LinkButton(label: "Follow the Developer on GitHub", urlSring: "https://Github.com/ipkalid")
        }
      
    }
}
