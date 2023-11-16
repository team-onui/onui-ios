import Foundation

final class SunStoreViewModel: BaseViewModel {
    private let changeThemeUseCase: ChangeThemeUseCase

    init(changeThemeUseCase: ChangeThemeUseCase) {
        self.changeThemeUseCase = changeThemeUseCase
    }

    func changeTheme(theme: Theme) {
        var themeType: ThemeType {
            switch theme {
            case .standard:
                return .standard
            case .hong:
                return .hong
            case .ssac:
                return .ssac
            case .nya:
                return .nya
            }
        }
        addCancellable(changeThemeUseCase.execute(theme: themeType)) { _ in }
    }
}
