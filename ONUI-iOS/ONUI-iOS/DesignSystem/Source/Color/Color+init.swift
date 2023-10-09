import Foundation
import SwiftUI

public enum ColorType: String {
    case lighten1 = "Lighten 1"
    case lighten2 = "Lighten 2"
    case `default` = "Default"
    case darken1 = "Darken 1"
    case darken2 = "Darken 2"
    case gray0 = "gray 0"
    case gray3 = "gray 3"
    case gray5 = "gray 5"
    case gray7 = "gray 7"
    case gray10 = "gray 10"
    case errorLighten1 = "Erro Lighten 1"
    case errorLighten2 = "Error Lighten 2"
    case ErrorDefault = "default"
    case errorDarken1 = "Error Darken 1"
    case errorDarken2 = "Error Darken 2"
}

extension Color {
    init(type: ColorType) {
        self.init("\(type.rawValue)")
    }
    
    public func darkModeColor(_ dark: Color) -> Color {
        let color = UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            return UITraitCollection.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(self)
        }
        return Color(uiColor: color)
    }
}
