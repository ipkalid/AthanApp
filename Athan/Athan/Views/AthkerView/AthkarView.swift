//
//  AthkarView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 12/09/2021.
//

import SwiftUI

struct AthkarView: View {
    
    init() {
        //UINavigationBar.appearance().backgroundColor = .clear
        // UINavigationBar.appearance().isHidden = false
        //  UINavigationBar.appearance().barTintColor = .clear
        
       // UITabBar.appearance().backgroundColor = UIColor.red

       // let customFont:UIFont = UIFont.preferredFont(forTextStyle: .title1)

        let customFont:UIFont = UIFont(name: "ArefRuqaa-Bold", size: 32)!
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(named: "Yellow")!,
            .font : customFont
            
    ]
      
        
    }
    var body: some View {
     NavigationView{
            AthkarGridView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("أ ذكار")
        }
    }
}

struct AthkarView_Previews: PreviewProvider {
    static var previews: some View {
        AthkarView()
    }
}
