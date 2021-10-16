//
//  AthkarView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 12/09/2021.
//

import SwiftUI

struct AthkarView: View {
    
    
    var body: some View {
        NavigationView{
            
            ScrollView(){
                Spacer()
                    .frame(height:40)
                
                NavigationLink(destination: TasbihView(jsonFileName: "PostPrayer_azkar", title: "أذكار الصلاة")) {
                    AthkarBigButton(
                        title: "أذكار الصلاة",
                        titleColor: .white,
                        backgroundColor: Color("Light Green")
                    )
                }
                
                Spacer()
                    .frame(height:20)
                
                NavigationLink(destination: TasbihView(jsonFileName: "azkar_sabah", title: "أذكار الصباح")) {
                    AthkarBigButton(
                        title: "أذكار الصباح",
                        titleColor: .black,
                        backgroundColor: AppColors.yellow
                    )
                }
                
                Spacer()
                    .frame(maxWidth: .infinity, minHeight: 20)
                
                
                NavigationLink(destination: TasbihView(jsonFileName: "azkar_massa", title: "أذكار المساء")) {
                    AthkarBigButton(
                        title: "أذكار المساء",
                        titleColor: .white,
                        backgroundColor: Color(hex: "091740")
                    )
                    
                }
                
                
                Spacer()
                    .frame(height:40)
                
                
            }
            .padding(.top,1)
            .background(AppColors.backgroundColor.ignoresSafeArea())
            
            .navigationTitle("الأذكار")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    NavigationTitleText("الأذكار")
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

struct AthkarBigButton: View {
    var title:String
    var titleColor: Color
    var backgroundColor: Color
    var body: some View {
        NavigationTitleText(title, size: 44, color: titleColor)
            .padding()
            .frame(width: UIScreen.screenWidth * 0.8,height:UIScreen.screenHeight / 5,alignment: .bottomTrailing)
            .padding()
            .background(backgroundColor)
            .cornerRadius(8)
            .shadow(radius: 5)
    }
}
