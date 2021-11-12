import SwiftUI

struct TasbihView: View {
    @ObservedObject var vm: TasbihView.ViewModel
    var title: LocalizedStringKey

    init(jsonFileName: String, title: LocalizedStringKey) {
        vm = TasbihView.ViewModel(fileName: jsonFileName)
        self.title = title
    }

    var body: some View {
        ZStack(alignment: .top) {
            AppColors.backgroundColor.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                ScrollViewReader { value in
                    Spacer()
                        .frame(maxWidth: .infinity, minHeight: 25)

                    ForEach(vm.azkarConents.indices) { i in
                        ZekrCardView(
                            zekrContent: vm.azkarConents[i],
                            onTap: { vm.toTheNextCard(index: i, scrollValue: value) }
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
                LogoTextStyleView(title)
            }
        }
    }
}

extension TasbihView {
    class ViewModel: ObservableObject {
        @Published var azkarConents: [ZekrContent] = []

        init(fileName: String) {
            guard let azkar = loadJson(fileName: fileName) else { return }
            azkarConents = azkar.content
        }

        func toTheNextCard(index: Int, scrollValue: ScrollViewProxy) {
            if index < (azkarConents.count - 1) {
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
                debugPrint("Error Tsbih View Model \(error.localizedDescription)")
                return nil
            }
        }
    }
}
