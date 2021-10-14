//
//  SettingView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 12/10/2021.
//

import SwiftUI

struct SettingView: View {
    
    init(){
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    var body: some View {
        NavigationView{
            ZStack{
                AppColors.backgroundColor.ignoresSafeArea()
            ScrollView{
                Spacer()
                    .frame(height:20)
                Text("fff")
                Text("fff")
                Spacer()
            }
            .padding(.top,1)
                
            }
            .navigationBarTitleDisplayMode(.inline)
       
        .toolbar {
            ToolbarItem(placement: .principal) {
                NavigationTitleText("الإعدادات")
            }
            
        }
        
    }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
