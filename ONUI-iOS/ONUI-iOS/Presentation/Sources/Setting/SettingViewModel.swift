import Foundation

final class SettingViewModel: BaseViewModel {
    @Published var isFiltering: Bool = false {
        didSet {
            if oldValue != isFiltering {
                changeFiltering()
            }
        }
    }
    @Published var profile: ProfileEntity? {
        didSet {
            isFiltering = profile?.onFiltering ?? false
        }
    }
    @Published var goToOnboarding = false
    @Published var logout = false
    @Published var withdraw = false
    @Published var showAlert = false {
        didSet {
            if !showAlert {
                logout = false
                withdraw = false
            }
        }
    }

    private let changeFilteringUseCase: ChangeFilteringUseCase
    private let fetchProfileUseCase: FetchProfileUseCase
    private let withdrawUseCase: WithdrawUseCase
    private let logoutUseCase: LogoutUseCase

    init(
        changeFilteringUseCase: ChangeFilteringUseCase,
        fetchProfileUseCase: FetchProfileUseCase,
        withdrawUseCase: WithdrawUseCase,
        logoutUseCase: LogoutUseCase
    ) {
        self.changeFilteringUseCase = changeFilteringUseCase
        self.fetchProfileUseCase = fetchProfileUseCase
        self.withdrawUseCase = withdrawUseCase
        self.logoutUseCase = logoutUseCase
    }

    func onAppear() {
        fetchProfile()
    }

    private func fetchProfile() {
        addCancellable(fetchProfileUseCase.execute()) { [weak self] profile in
            self?.profile = profile
        }
    }

    func changeFiltering() {
        addCancellable(changeFilteringUseCase.execute(isFiltering: isFiltering)) { _ in }
    }

    func logoutButtonDidTap() {
        showAlert = true
        logout = true
    }
    
    func logoutFunc() {
        logoutUseCase.execute()
    }

    func withdrawButtonDidTap() {
        showAlert = true
        withdraw = true
    }
    func withdrawFunc() {
        addCancellable(withdrawUseCase.execute()) { _ in }
    }
}
