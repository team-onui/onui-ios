import SwiftUI

extension View {
    func frame(_ size: CGFloat, alignment: Alignment = .center) -> some View {
        self.frame(width: size, height: size, alignment: alignment)
    }
}
