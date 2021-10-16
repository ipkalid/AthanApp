//
//  TasbihView.swift
//  Athan
//
//  Created by Khalid Alhazmi on 10/10/2021.
//

import SwiftUI

struct PostPrayerAthkarView_Previewsnn: PreviewProvider {
    static var previews: some View {
        PostPrayerAthkarView()
    }
}

struct TasbihView: View {
    
    @ObservedObject var viewModel:TasbihView.ViewModel
    var showgroundColor:Bool
    var title:String
    
    init(jsonFileName:String, title:String, showgroundColor: Bool = true ){
        viewModel = TasbihView.ViewModel(fileName: jsonFileName)
        self.title = title
        self.showgroundColor = showgroundColor
        
    }
    var body: some View {
        ZStack(alignment: .top){
            if(showgroundColor){
                AppColors.backgroundColor.ignoresSafeArea()
                
            }
            
            ScrollView( showsIndicators: false ){
                ScrollViewReader{ value in
                    Spacer()
                        .frame(maxWidth: .infinity, minHeight: 25)
                    
                    ForEach((0..<viewModel.azkarConents!.count)){ i in
                        
                        VStack{
                            Spacer()
                                .frame(height:10)
                            
                            ZekrCardView(
                                zekrContent: viewModel.azkarConents![i] ,
                                onTap: {
                                    if(i < (viewModel.azkarConents!.count - 1)){
                                        withAnimation{ value.scrollTo(i + 1, anchor: .top)
                                        }
                                        
                                    }
                                }
                            )
                            
                            
                            Spacer()
                                .frame(height:10)
                            
                        }.id(i)
                    }
                    Spacer()
                    .frame(height:30)
                    
                }
            }
            .padding(.top,1)
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                NavigationTitleText(title)
            }
            
//            ToolbarItem(placement: .navigationBarLeading) {
//              
//                Button(action:{
//                    print("f")
//                }){
//                    Image(systemName: "goforward")
//                }
//                
//            }
        }
        .alert(viewModel.dialogTitle, isPresented: $viewModel.showDialog) {
            Button("نعم",role: .destructive) {
                viewModel.startAgain()
            }
            Button("لا", role: .cancel) {
            }
        } message: {
            Text(viewModel.dialogTitle)
        }
        
    }
}
extension TasbihView{
    class ViewModel: ObservableObject{
        @Published var counter:Int = 0
        @Published var showDialog = false
        
        
        @Published var dialogTitle =  "إعادة الأذكار"
        @Published var dialogMessage = "هل تريد إعادة الأذكار؟"
        @Published var currentZekr:ZekrContent?
        @Published var azkarConents:[ZekrContent]?
        
        
        private var azkar:Azkar?
        private var currentZektIndex = 0
        
        
        init(fileName:String){
            guard  let azkar = loadJson(fileName: fileName) else{return}
            self.azkar = azkar;
            
            self.currentZekr = azkar.content[0];
            self.azkarConents = azkar.content;
            counter = azkar.content[0].contentRepeat;
        }
        
        
        func startAgain(){
            guard let azkar = azkar else{return}
            currentZektIndex = 0
            self.currentZekr = azkar.content[0];
            counter = azkar.content[0].contentRepeat;
        }
        
        private func finishAction(){
            dialogTitle = "لقد أنهيت الأذكار"
            dialogMessage = "هل تريد إعادة الأذكار؟"
            showDialog = true;
            
        }
        
        
        func update(){
            
            guard
                let currentZekr = currentZekr,
                let azkar = azkar else { return }
            
            
            
            
            if(counter < currentZekr.contentRepeat){
                counter+=1;
            }else{
                if(currentZektIndex > (azkar.content.count - 2)){
                    finishAction()
                }else{
                    currentZektIndex+=1;
                    self.currentZekr = azkar.content[currentZektIndex]
                }
                
                counter = 1;
                
            }
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
        
        
        
        
        
        
        
        private func loadJson(fileName: String) -> Azkar? {
            let decoder = JSONDecoder()
            
            guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {return nil}
            let url = URL(fileURLWithPath: path)
            do{
                let JsonData = try Data(contentsOf: url)
                
                guard let azkar = try? decoder.decode(Azkar.self, from: JsonData) else{
                    return nil
                }
                
                return azkar
            }catch{
                print("Error Happen")
                return nil
            }
            
        }
    }
}

