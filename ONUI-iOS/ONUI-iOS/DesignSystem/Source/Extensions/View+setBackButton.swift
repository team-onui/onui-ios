import SwiftUI

struct BackButtonModifier: ViewModifier {
    let willDismiss: () -> Void
    let title: String

    public init(
        willDismiss: @escaping () -> Void,
        title: String = ""
    ) {
        self.willDismiss = willDismiss
        self.title = title
    }

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        willDismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Image(.backButton)
                                .resizable()
                                .frame(48)

                            Text(title)
                                .onuiFont(.title(.large), color: .GrayScale.Surface.onSurface)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarBackground({
                Color.GrayScale.Surface.surface
            })
    }
}
public extension View {
    func setBackButton(
        title: String = "",
        willDismiss: @escaping () -> Void
    ) -> some View {
        modifier(BackButtonModifier(willDismiss: willDismiss, title: title))
    }
}

// SwipeGesture로 뒤로갈 수 있게 하는 extension
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
