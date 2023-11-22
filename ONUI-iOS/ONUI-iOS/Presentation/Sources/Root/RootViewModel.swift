import Foundation
import FirebaseMessaging

final class RootViewModel: BaseViewModel {
    @Published var showSignin = false
    @Published var theme: ThemeType = .standard
    private let refreshTokenUseCase: RefreshTokenUseCase
    private let fetchProfileUseCase: FetchProfileUseCase
    private let sendDeviceTokenUseCase: SendDeviceTokenUseCase
    
    init(
        refreshTokenUseCase: RefreshTokenUseCase,
        fetchProfileUseCase: FetchProfileUseCase,
        sendDeviceTokenUseCase: SendDeviceTokenUseCase
    ) {
        self.refreshTokenUseCase = refreshTokenUseCase
        self.fetchProfileUseCase = fetchProfileUseCase
        self.sendDeviceTokenUseCase = sendDeviceTokenUseCase
    }
    
    func onAppear(
        onSuccess: @escaping () -> Void,
        onError: @escaping (Error) -> Void
    ) {
        addCancellable(refreshTokenUseCase.execute(), onReceiveValue: { _ in
            self.fetchProfile(action: onSuccess)
            self.sendDeviceToken()
        }, onReceiveError: onError)
    }

    private func sendDeviceToken() {
        addCancellable(sendDeviceTokenUseCase.execute(token: Messaging.messaging().fcmToken ?? "")) { _ in }
    }

    private func fetchProfile(action: @escaping () -> Void) {
        addCancellable(fetchProfileUseCase.execute()) { profile in
            self.theme = profile.theme            
            action()
        }
    }
}
