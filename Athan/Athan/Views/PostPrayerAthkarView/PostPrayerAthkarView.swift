//
//  PostPrayerAthkarView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 12/10/2021.
//

import SwiftUI

struct PostPrayerAthkarView: View {
    var body: some View {
       NavigationView{
         ZStack{
            AppColors.backgroundColor.ignoresSafeArea()
             
                  TasbihView(jsonFileName: "PostPrayer_azkar", title: "أذكار الصلاة",showgroundColor: false)
           
             .padding(.top,1)
         }
         .navigationBarTitleDisplayMode(.inline)
       }
     
    }
}


struct PostPrayerAthkarView_Previews: PreviewProvider {
    static var previews: some View {
        PostPrayerAthkarView()
    }
}
