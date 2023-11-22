import Combine
import GoogleSignIn
import FirebaseMessaging

final class SigninViewModel: BaseViewModel {
    @Published var isNavigatedToMain: Bool = false
    @Published var myTheme: ThemeType = .standard

    private let googleSigninUseCase: GoogleSigninUseCase
    private let appleSigninUseCase: AppleSigninUseCase
    private let fetchProfileUseCase: FetchProfileUseCase
    private let sendDeviceTokenUseCase: SendDeviceTokenUseCase

    init(
        googleSigninUseCase: GoogleSigninUseCase,
        appleSigninUseCase: AppleSigninUseCase,
        fetchProfileUseCase: FetchProfileUseCase,
        sendDeviceTokenUseCase: SendDeviceTokenUseCase
    ) {
        self.googleSigninUseCase = googleSigninUseCase
        self.appleSigninUseCase = appleSigninUseCase
        self.fetchProfileUseCase = fetchProfileUseCase
        self.sendDeviceTokenUseCase = sendDeviceTokenUseCase
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
            self?.sendDeviceToken()
        }
    }

    func appleSignin(accessToken: String) {
        addCancellable(appleSigninUseCase.execute(token: accessToken)) { [weak self] _ in
            self?.fetchProfile()
            self?.isNavigatedToMain.toggle()
            self?.sendDeviceToken()
        }
    }

    private func sendDeviceToken() {
        addCancellable(sendDeviceTokenUseCase.execute(token: Messaging.messaging().fcmToken ?? "")) { _ in }
    }

    private func fetchProfile() {
        addCancellable(fetchProfileUseCase.execute()) { [weak self] profile in
            self?.myTheme = profile.theme
        }
    }
}
