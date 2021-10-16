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
                    .frame(maxWidth: .infinity, minHeight: 40)
                
                VStack(spacing:20){
                    NavigationLink(destination: TasbihView(jsonFileName: "PostPrayer_azkar")) {
                        AthkarBigButton(
                            title: "أذكار بعد الصلاة",
                            titleColor: .white,
                            backgroundColor: Color("Light Green")
                        )
                    }
                    
                    
                    NavigationLink(destination: TasbihView(jsonFileName: "azkar_sabah")) {
                        AthkarBigButton(
                            title: "أذكار الصباح",
                            titleColor: .black,
                            backgroundColor: AppColors.yellow
                        )
                    }
                    
                    
                    
                    
                    NavigationLink(destination: TasbihView(jsonFileName: "azkar_massa")) {
                        AthkarBigButton(
                            title: "أذكار المساء",
                            titleColor: .white,
                            backgroundColor: Color(hex: "091740")
                        )
                        
                    }
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
