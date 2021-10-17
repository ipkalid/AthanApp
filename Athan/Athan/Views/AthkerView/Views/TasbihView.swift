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

                    ForEach(0 ..< viewModel.azkarConents.count) { i in

                        VStack {
                            Spacer()
                                .frame(height: 10)

                            ZekrCardView(
                                zekrContent: viewModel.azkarConents[i],
                                onTap: {
                                    if i < (viewModel.azkarConents.count - 1) {
                                        withAnimation { value.scrollTo(i + 1, anchor: .top)
                                        }
                                    }
                                }
                            )

                            Spacer()
                                .frame(height: 10)

                        }.id(i)
                    }
                    Spacer()
                        .frame(height: 30)
                }
            }
            .padding(.top, 1)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                NavigationTitleText(viewModel.title)
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
                print("Error Happen")
                return nil
            }
        }
    }
}
