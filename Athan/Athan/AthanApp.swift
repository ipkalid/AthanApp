//
//  AthanApp.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import SwiftUI

@main
struct AthanApp: App {
    @StateObject var environmentViewModel = EnvironmentViewModel()

    var body: some Scene {
        WindowGroup {
            AppTapView()
                .preferredColorScheme(.light)
                .environmentObject(environmentViewModel)
        }
    }
}
