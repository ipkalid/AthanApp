//
//  AthanApp.swift
//  Athan
//
//  Created by Khalid Alhazmi on 11/09/2021.
//

import SwiftUI

@main
struct AthanApp: App {
    @StateObject var env = EnvViewModel.shared

    var body: some Scene {
        WindowGroup {
            Group {
                if env.showOnboarding == false {
                    AppTapView()

                } else {
                    OnboardingView()
                }
            }
            .environment(\.colorScheme, .light)
            .environmentObject(env)
        }
    }
}
