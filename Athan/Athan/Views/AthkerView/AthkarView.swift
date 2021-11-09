//
//  AthkarView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 12/09/2021.
//

import SwiftUI

struct AthkarView: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Spacer()
                    .frame(maxWidth: .infinity, minHeight: 40)

                VStack(spacing: 20) {
                    NavigationLink(destination: TasbihView(jsonFileName: "PostPrayer_azkar", title: "Post Prayer Athkar")) {
                        AthkarBigButton(
                            title: "Post Prayer Athkar",
                            titleColor: .white,
                            backgroundColor: Color("Light Green")
                        )
                    }.buttonStyle(.plain)

                    NavigationLink(destination: TasbihView(jsonFileName: "azkar_sabah", title: "Morning Athkar")) {
                        AthkarBigButton(
                            title: "Morning Athkar",
                            titleColor: .black,
                            backgroundColor: AppColors.yellow
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink(destination: TasbihView(jsonFileName: "azkar_massa", title: "Evening Athkar")) {
                        AthkarBigButton(
                            title: "Evening Athkar",
                            titleColor: .white,
                            backgroundColor: Color(hex: "091740")
                        )
                    }
                    .buttonStyle(.plain)
                }

                Spacer()
                    .frame(height: 30)
            }
            .padding(.top, 1)
            .background(AppColors.backgroundColor.ignoresSafeArea())

            .navigationTitle("Athkar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    LogoTextStyleView("Athkar")
                }
            }
        }
        .accentColor(AppColors.yellow)
    }
}

struct AthkarView_Previews: PreviewProvider {
    static var previews: some View {
        AthkarView()
    }
}
