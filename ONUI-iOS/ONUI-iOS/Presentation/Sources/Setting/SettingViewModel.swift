import Foundation
import SwiftUI

final class SettingViewModel: BaseViewModel {
    private var name: String = ""
    @Published var isFiltering: Bool = false {
        didSet {
            if oldValue != isFiltering {
                changeFiltering()
            }
        }
    }
    @Published var profile: ProfileEntity = .init(sub: "", name: "", profileTheme: "FFFFFF", theme: .standard, onFiltering: false)
    @Published var isShowLogout = false
    @Published var isShowWithdraw = false
    @Published var selectedColor: Color = .white

    private let changeFilteringUseCase: ChangeFilteringUseCase
    private let fetchProfileUseCase: FetchProfileUseCase
    private let withdrawUseCase: WithdrawUseCase
    private let logoutUseCase: LogoutUseCase
    private let changeUseColorUseCase: ChangeUserColorUseCase
    private let renameUseCase: RenameUseCase

    init(
        changeFilteringUseCase: ChangeFilteringUseCase,
        fetchProfileUseCase: FetchProfileUseCase,
        withdrawUseCase: WithdrawUseCase,
        logoutUseCase: LogoutUseCase,
        changeUseColorUseCase: ChangeUserColorUseCase,
        renameUseCase: RenameUseCase
    ) {
        self.changeFilteringUseCase = changeFilteringUseCase
        self.fetchProfileUseCase = fetchProfileUseCase
        self.withdrawUseCase = withdrawUseCase
        self.logoutUseCase = logoutUseCase
        self.changeUseColorUseCase = changeUseColorUseCase
        self.renameUseCase = renameUseCase
    }
    
    func changeProfile() {
        if name != profile.name {
            rename()
        }
        guard profile.profileTheme != selectedColor.toHexString() else { return }
        changeUseColor()
    }

    private func rename() {
        addCancellable(renameUseCase.execute(name: profile.name)) { profile in
            self.profile = profile
        }
    }

    private func changeUseColor() {
        guard let hex = selectedColor.toHexString() else { return }
        addCancellable(changeUseColorUseCase.execute(hex: hex)) { profile in
            self.profile = profile
        }
    }

    func onAppear() {
        fetchProfile()
    }

    private func fetchProfile() {
        addCancellable(fetchProfileUseCase.execute()) { [weak self] profile in
            self?.selectedColor = .init(hexCode: profile.profileTheme)
            self?.profile = profile
            self?.name = profile.name
            self?.isFiltering = profile.onFiltering
        }
    }

    func changeFiltering() {
        addCancellable(changeFilteringUseCase.execute(isFiltering: isFiltering)) { _ in }
    }

    func logoutButtonDidTap() {
        isShowLogout = true
    }
    
    func logoutFunc(move: () -> Void) {
        logoutUseCase.execute()
        move()
    }

    func withdrawButtonDidTap() {
        isShowWithdraw = true
    }
    func withdrawFunc(move: () -> Void) {
        addCancellable(withdrawUseCase.execute()) { _ in }
        move()
    }
}
