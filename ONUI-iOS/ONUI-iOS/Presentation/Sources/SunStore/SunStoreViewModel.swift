import Foundation

final class SunStoreViewModel: BaseViewModel {
    @Published var rice: Int = 0
    @Published var isSuccessChangeTheme = false
    @Published var isShowAlert = false
    @Published var themeList = [ThemeEntity]()
    @Published var currentBoughtTheme: ThemeEntity?

    private let changeThemeUseCase: ChangeThemeUseCase
    private let buyThemeUseCase: BuyThemeUseCase
    private let fetchMyRiceUseCase: FetchMyRiceUseCase
    private let fetchThemeListUseCase: FetchThemeListUseCase

    init(
        changeThemeUseCase: ChangeThemeUseCase,
        buyThemeUseCase: BuyThemeUseCase,
        fetchMyRiceUseCase: FetchMyRiceUseCase,
        fetchThemeListUseCase: FetchThemeListUseCase
    ) {
        self.changeThemeUseCase = changeThemeUseCase
        self.buyThemeUseCase = buyThemeUseCase
        self.fetchMyRiceUseCase = fetchMyRiceUseCase
        self.fetchThemeListUseCase = fetchThemeListUseCase
    }

    func onAppear() {
        fetchMyRice()
        fetchThemeList()
    }

    private func fetchMyRice() {
        addCancellable(fetchMyRiceUseCase.execute()) { rice in
            self.rice = rice
        }
    }

    private func fetchThemeList() {
        addCancellable(fetchThemeListUseCase.execute()) { themeList in
            self.themeList = themeList.filter { $0.theme != .standard}
        }
    }

    func changeTheme(completion: @escaping (Theme) -> Void) {
        guard let currentBoughtTheme else { return }
        var themeType: ThemeType {
            switch currentBoughtTheme.theme {
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
        addCancellable(changeThemeUseCase.execute(theme: themeType)) { _ in
            completion(currentBoughtTheme.theme)
        }
    }

    func buyTheme(theme: ThemeEntity) {
        var themeType: ThemeType {
            switch theme.theme {
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
        addCancellable(buyThemeUseCase.execute(theme: themeType)) { themeList in
            self.rice -= theme.price
            self.themeList = themeList.filter { $0.theme != .standard}
            self.isShowAlert = true
            self.currentBoughtTheme = theme
        }
    }
}
