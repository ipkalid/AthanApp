//
//  AppSettingSection.swift
//  Athan
//
//  Created by Khalid Alhazmi on 16/10/2021.
//

import SwiftUI


struct Actions : View {
    var actions: [(title: String, action: ()->Void)]
    init(_ actions:[(title: String, action: ()->Void)]){
        self.actions = actions
    }
    var body: some View{
        ForEach(0..<actions.count){ i in
            Button(actions[i].title,action: actions[i].action)
        }
        
    }
}

struct AppSettingSection: View {
    
    @State private var showSheet = false;
    @State private var sheetTitle = ""
    
    @State var actions:Actions?
    
    
    var body: some View {
        return Section(header: Text("إعدادات الأذان")) {
            NavigationLink(destination: {
                Text("View 2")
            }){  Text("الإشعارات")}
            
         
            Button("نوع التقويم"){
                showSheet = true
                sheetTitle =  "نوع التقويم"
                
                let action1 =  ("حنفي", {print("B")})
                let action2 =  ("حنبلي - مالكي - شافعي", {print("B")})
                
                actions =  Actions([action1,action2])
                
            }
            
            Button("الحساب الفقهي للصلاة"){
                showSheet = true
                sheetTitle =  "الحساب الفقهي لصلاة العصر"
                
                let action1 =  ("حنفي", {print("B")})
                let action2 =  ("حنبلي - مالكي - شافعي", {print("B")})
                
                actions =  Actions([action1,action2])
            }
            
            
        }
        .listRowSeparatorTint(.white.opacity(0.3))
        .listRowBackground(AppColors.SettinglistRowBackground)
        .confirmationDialog(sheetTitle, isPresented: $showSheet,titleVisibility: .visible, actions:{ actions })
    }
}
