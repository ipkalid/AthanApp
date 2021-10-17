import Adhan
import Foundation
import SwiftUI

class EnvironmentViewModel: ObservableObject {
    @Published var preferredColorScheme: ColorScheme = .light

    @Published var calculationMethod = CalculationMethod.ummAlQura

    @Published var madhabType = Madhab.shafi

    func getMadhabName() -> String {
        switch madhabType {
        case .shafi:
            return "حنبلي - مالكي - شافعي"
        case .hanafi:
            return "حنفي"
        }
    }

    func getCalculationMethod() -> String {
        switch calculationMethod {
        case .muslimWorldLeague:
            return "رابطة العالم الإسلامي"
        case .ummAlQura:
            return "أم القرى"
        case .dubai:
            return "دبي"
        case .kuwait:
            return "الكويت"
        case .qatar:
            return "قطر"
        default:
            return "Other"
        }
    }

    init() {
        print(madhabType.rawValue)
    }

    private var isDarkMode: Bool = false
}
