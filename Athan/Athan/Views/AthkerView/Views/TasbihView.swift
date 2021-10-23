import SwiftUI

struct TasbihView: View {
    @ObservedObject var viewModel: TasbihView.ViewModel
    
    init(jsonFileName: String) {
        viewModel = TasbihView.ViewModel(fileName: jsonFileName)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            AppColors.backgroundColor.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                ScrollViewReader { value in
                    Spacer()
                        .frame(maxWidth: .infinity, minHeight: 25)
                    
                    ForEach(viewModel.azkarConents.indices) { i in // indices = 0 ..< 2
                        ZekrCardView(
                            zekrContent: viewModel.azkarConents[i],
                            onTap: {viewModel.toTheNextCard(index: i, scrollValue: value)}
                        )
                            .padding(.vertical, 7.5)
                            .id(i)
                    }
                    Spacer()
                        .frame(height: 30)
                }
            }
            .padding(.top, 1)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                LogoTextStyleView(viewModel.title)
            }
        }
    }
}

extension TasbihView {
    class ViewModel: ObservableObject {
        @Published var azkarConents: [ZekrContent] = []
        @Published var title: String = ""
        
        init(fileName: String) {
            guard let azkar = loadJson(fileName: fileName) else { return }
            azkarConents = azkar.content
            title = azkar.title
        }
        
        func toTheNextCard( index:Int,   scrollValue: ScrollViewProxy){
            if (index < (azkarConents.count - 1)) {
                withAnimation {
                    scrollValue.scrollTo(index + 1, anchor: .center)
                }
            }
        }
        
        
        private func loadJson(fileName: String) -> Azkar? {
            let decoder = JSONDecoder()
            
            guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return nil }
            let url = URL(fileURLWithPath: path)
            do {
                let JsonData = try Data(contentsOf: url)
                
                guard let azkar = try? decoder.decode(Azkar.self, from: JsonData) else {
                    return nil
                }
                
                return azkar
            } catch {
                print("Error Tsbih View Model \(error.localizedDescription)")
                return nil
            }
        }
    }
}
