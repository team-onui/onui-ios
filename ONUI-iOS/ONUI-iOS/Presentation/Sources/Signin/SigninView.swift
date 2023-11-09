import SwiftUI
import AuthenticationServices

struct SigninView: View {
    @State private var buttonHeight: CGFloat = 100
    @StateObject var viewModel: SigninViewModel
    @StateObject var uiState = UIStateModel()

    private let mainView = DI.container.resolve(MainView.self)!

    init(
        viewModel: SigninViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            CarouselView(uiState: uiState)

            let count = 4
            HStack(spacing: 4) {
                ForEach(0..<count, id: \.self) { index in
                    let cardIndex: Int = uiState.activeCard
                    Capsule()
                        .fill(cardIndex == index ?
                              Color.GrayScale.Background.onBackground :
                                .GrayScale.Background.onBackgroundVariant)
                        .frame(width: cardIndex == index ? 24 : 8, height: 8)
                        .animation(
                            .spring(
                                response: 0.5,
                                dampingFraction: 0.7,
                                blendDuration: 1
                            ),
                            value: cardIndex
                        )
                }
            }

            Spacer()

            HStack(spacing: 8) {
                Button {
                    viewModel.isNavigatedToMain.toggle()
                } label: {
                    VStack(spacing: 34) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("시작하기")
                                .onuiFont(.title(.medium), color: .GrayScale.Surface.onSurfaceVariant)

                            Text("오누이")
                                .onuiFont(.headline(.medium), color: .GrayScale.Surface.surface)
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
                }

                VStack(spacing: 8) {
                    Button(action: viewModel.googleSigninButtonDidTap) {
                        functionButton(title: "Google", subTitle: "인증하기", image: .Google)
                            .overlay {
                                GeometryReader { proxy in
                                    Color.clear.onAppear {
                                        buttonHeight = proxy.size.height
                                    }
                                }
                            }
                    }

                    appleButton()
                        .frame(maxHeight: buttonHeight)
//                    functionButton(title: "서비스", subTitle: "소개", image: .Link)
                }
            }
            .padding(16)
        }
        .background(Color.GrayScale.Background.background)
        .fullScreenCover(isPresented: $viewModel.isNavigatedToMain) {
            mainView
        }
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
                .frame(width: image == .Google ? 48 : 32, height: image == .Google ? 48 : 32)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(32)
    }

    @ViewBuilder
    func appleButton() -> some View {
        SignInWithAppleButton(.continue) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authResults):
                guard let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential else { return }
                let UserIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                let email = appleIDCredential.email
                let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                print("ID Token:", IdentityToken)
                print("authorizationCode:", AuthorizationCode)
                print("name:", name, fullName)
                print("email:", email)
            case .failure(let error):
                print(error.localizedDescription)
                print("error")
            }
        }
        .signInWithAppleButtonStyle(.black)
        .cornerRadius(32)
    }
}
