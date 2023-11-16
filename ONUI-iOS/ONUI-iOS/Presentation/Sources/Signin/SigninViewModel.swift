import Combine
import GoogleSignIn

final class SigninViewModel: BaseViewModel {
    @Published var isNavigatedToMain: Bool = false
    @Published var myTheme: ThemeType = .standard

    private let googleSigninUseCase: GoogleSigninUseCase
    private let appleSigninUseCase: AppleSigninUseCase
    private let fetchProfileUseCase: FetchProfileUseCase

    init(
        googleSigninUseCase: GoogleSigninUseCase,
        appleSigninUseCase: AppleSigninUseCase,
        fetchProfileUseCase: FetchProfileUseCase
    ) {
        self.googleSigninUseCase = googleSigninUseCase
        self.appleSigninUseCase = appleSigninUseCase
        self.fetchProfileUseCase = fetchProfileUseCase
    }

    func googleSigninButtonDidTap() {
        guard let vc = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [self] user, error in
            guard error == nil else { return }
            guard let accessToken = user?.user.accessToken.tokenString else { return }
            googleSignin(accessToken: accessToken)
        }
    }

    private func googleSignin(accessToken: String) {
        addCancellable(googleSigninUseCase.execute(token: accessToken)) { [weak self] _ in
            self?.fetchProfile()
            self?.isNavigatedToMain.toggle()
        }
    }

    func appleSignin(accessToken: String) {
        addCancellable(appleSigninUseCase.execute(token: accessToken)) { [weak self] _ in
            self?.fetchProfile()
            self?.isNavigatedToMain.toggle()
        }
    }

    private func fetchProfile() {
        addCancellable(fetchProfileUseCase.execute()) { [weak self] profile in
            self?.myTheme = profile.theme
        }
    }
}
