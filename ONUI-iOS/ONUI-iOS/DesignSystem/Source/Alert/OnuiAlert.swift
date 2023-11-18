import SwiftUI

public extension View {
    func onuiAlert(
        isPresented: Binding<Bool>,
        title: String,
        content: String,
        action: @escaping () -> Void
    ) -> some View {
        self.fullScreenCover(isPresented: isPresented) {
            OnuiAlert(
                title: title,
                content: content,
                action: action
            )
        }
    }
}

public struct OnuiAlert: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var animate = false
    let title: String
    let content: String
    let action: () -> Void

    public init(
        title: String,
        content: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.content = content
        self.action = action
    }

    public var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
                .opacity(animate ? 1.0 : 0.0)
                .onTapGesture {
                    self.dismissAlert()
                }

            VStack(
                alignment: .leading,
                spacing: 24
            ) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .onuiFont(.title(.medium), color: .GrayScale.Surface.onSurface)

                    Text(content)
                        .onuiFont(.body(.small), color: .GrayScale.Outline.outline)
                }

                HStack(spacing: 8) {
                    alertButton(
                        "취소",
                        foregroundColor: .GrayScale.Surface.surfaceVariant,
                        backgroundColor: .GrayScale.Surface.surface
                    ) { }

                    alertButton(
                        "확인",
                        foregroundColor: .Primary.onPrimary,
                        backgroundColor: .Primary.primary
                    ) {
                        action()
                    }
                }
            }
            .padding(20)
            .background(Color.GrayScale.Surface.surface)
            .cornerRadius(16)
            .padding(20)
        }
        .onAppear {
            withAnimation(.easeIn(duration: 0.4)) {
                animate = true
            }
        }
        .background(Background())
    }

    private func dismissAlert() {
        withAnimation(.easeIn(duration: 0.4)) {
            animate = false
            self.presentationMode.wrappedValue.dismiss()
        }
    }

    @ViewBuilder
    func alertButton(
        _ text: String,
        foregroundColor: Color,
        backgroundColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
            dismissAlert()
        } label: {
            Text(text)
                .onuiFont(.body(.large), color: foregroundColor)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(12)
        }
    }
}
