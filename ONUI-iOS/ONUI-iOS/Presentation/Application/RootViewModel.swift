import Foundation

final class RootViewModel: BaseViewModel {
    @Published var page: Page? = nil
    @Published var showSignin = false
    private let refreshTokenUseCase: RefreshTokenUseCase
    
    init(refreshTokenUseCase: RefreshTokenUseCase) {
        self.refreshTokenUseCase = refreshTokenUseCase
    }
    
    func onAppear(
        onSuccess: @escaping () -> Void,
        onError: @escaping (Error) -> Void
    ) {
        addCancellable(refreshTokenUseCase.execute(), onReceiveValue: onSuccess, onReceiveError: onError)
    }
}
