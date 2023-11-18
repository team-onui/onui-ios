import Foundation

final class RootViewModel: BaseViewModel {
    @Published var showSignin = false
    @Published var theme: ThemeType = .standard
    private let refreshTokenUseCase: RefreshTokenUseCase
    private let fetchProfileUseCase: FetchProfileUseCase
    
    init(refreshTokenUseCase: RefreshTokenUseCase, fetchProfileUseCase: FetchProfileUseCase) {
        self.refreshTokenUseCase = refreshTokenUseCase
        self.fetchProfileUseCase = fetchProfileUseCase
    }
    
    func onAppear(
        onSuccess: @escaping () -> Void,
        onError: @escaping (Error) -> Void
    ) {
        addCancellable(refreshTokenUseCase.execute(), onReceiveValue: { _ in
            self.fetchProfile(action: onSuccess)
        }, onReceiveError: onError)
    }

    private func fetchProfile(action: @escaping () -> Void) {
        addCancellable(fetchProfileUseCase.execute()) { profile in
            self.theme = profile.theme            
            action()
        }
    }
}
