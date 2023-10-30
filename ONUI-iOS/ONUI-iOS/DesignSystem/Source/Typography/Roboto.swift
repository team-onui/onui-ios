import Foundation
import SwiftUI

public struct Roboto {
    public static func fontHeight(weight: OnuiFontWeight, size: CGFloat) -> CGFloat {
        UIFont(name: "Roboto-\(weight)", size: size)?.lineHeight ??
        UIFont.preferredFont(forTextStyle: .caption1).lineHeight
    }

    public static func registerFonts() {
        OnuiFontWeight.allCases.forEach {
            registerFont(bundle: .main, fontName: "Roboto-\($0.rawValue)", fontExtension: "ttf")
        }
    }
    
    private static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
