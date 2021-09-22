//
//  AthkarGridView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 12/09/2021.
//

import SwiftUI

struct AthkarGridView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    let offset:Double = 60;
    
    let array = 0...30
    var body: some View {
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    
                    LazyVGrid(columns:columns,spacing:20) {
                        ForEach(0..<array.count) { i in
                            
                           if(i <= 2){
                            NavigationLink(destination:Text("dd")){
                                AthkarCell()
                                    .offset(y: offset)
                                    .padding(.bottom, offset)
                            }
                           
                           }else{
                            NavigationLink(destination:Text("dd")){
                                AthkarCell()
                                    
                            }
                           }
                        }
                        
                    }.offset(y: -offset)
                }
                .padding(.horizontal)
                .padding(.top,1)

                
            }
        }
//        .ignoresSafeArea()
//    }
    
}

struct AthkarGridView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AthkarGridView()
                .navigationBarTitle("d")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
