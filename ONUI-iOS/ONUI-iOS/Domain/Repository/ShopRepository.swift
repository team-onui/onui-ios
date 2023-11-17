import Combine

protocol ShopRepository {
    func buyTheme(theme: ThemeType) -> AnyPublisher<[ThemeEntity], Error>
    func fetchThemeList() -> AnyPublisher<[ThemeEntity], Error>
}
