import SwiftUI

struct SigninView: View {
    @StateObject var viewModel: SigninViewModel

    init(
        viewModel: SigninViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            Spacer()

            HStack(spacing: 8) {
                VStack(spacing: 34) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("시작하기")
                            .onuiFont(.title(.medium), color: .GrayScale.Surface.onSurfaceVariant)

                        Text("오누이")
                            .onuiFont(.title(.medium), color: .GrayScale.Surface.surface)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    OnuiImage(.SplashImage)
                        .frame(width: 48, height: 48)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Color.GrayScale.Surface.surfaceVariant)
                .cornerRadius(32)

                VStack(spacing: 8) {
                    functionButton(title: "Google", subTitle: "인증하기", image: .Google)

                    functionButton(title: "서비스", subTitle: "소개", image: .Link)
                }
            }
            .padding(16)
        }
        .background(Color.GrayScale.Background.background)
    }

    @ViewBuilder
    func functionButton(
        title: String,
        subTitle: String,
        image: OnuiImage.Image
    ) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .onuiFont(.title(.small), color: .GrayScale.Surface.surfaceVariant)

                Text(subTitle)
                    .onuiFont(.headline(.small), color: .GrayScale.Surface.onSurface)
            }

            Spacer()

            OnuiImage(image, renderingMode: image == .Link ? .template : .original)
                .foregroundColor(.GrayScale.Surface.onSurface)
                .frame(width: image == .Google ? 48 : 24, height: image == .Google ? 48 : 24)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(32)
    }
}

#Preview {
    SigninView(viewModel: .init())
}
