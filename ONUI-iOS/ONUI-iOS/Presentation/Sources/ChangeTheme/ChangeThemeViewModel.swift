import Foundation

final class ChangeThemeViewModel: BaseViewModel {
    @Published var themeList = [Theme]()
    @Published var selectedTheme: Theme?

    private let changeThemeUseCase: ChangeThemeUseCase
    private let fetchMyThemeUseCase: FetchMyThemeUseCase
    private let fetchProfileUseCase: FetchProfileUseCase

    init(changeThemeUseCase: ChangeThemeUseCase, fetchMyThemeUseCase: FetchMyThemeUseCase, fetchProfileUseCase: FetchProfileUseCase) {
        self.changeThemeUseCase = changeThemeUseCase
        self.fetchMyThemeUseCase = fetchMyThemeUseCase
        self.fetchProfileUseCase = fetchProfileUseCase
    }

    func onAppear() {
        fetchProfile()
        fetchThemeList()
    }

    private func fetchProfile() {
        addCancellable(fetchProfileUseCase.execute()) { theme in
            self.selectedTheme = theme.theme.toDomain()
        }
    }

    private func fetchThemeList() {
        addCancellable(fetchMyThemeUseCase.execute()) { themeList in
            self.themeList = themeList
        }
    }

    func changeTheme(theme: Theme, completion: @escaping (Theme) -> Void) {
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
        addCancellable(changeThemeUseCase.execute(theme: themeType)) { profile in
            completion(profile.theme.toDomain())
        }
    }
}
