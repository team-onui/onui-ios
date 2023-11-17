import Combine

protocol RemoteShopDataSource {
    func buyTheme(theme: ThemeType) -> AnyPublisher<[ThemeEntity], Error>
    func fetchThemeList() -> AnyPublisher<[ThemeEntity], Error>
}

final class RemoteShopDataSourceImpl: BaseRemoteDataSource<ShopAPI>, RemoteShopDataSource {
    func buyTheme(theme: ThemeType) -> AnyPublisher<[ThemeEntity], Error> {
        request(.buyTheme(theme.rawValue), dto: FetchThemeListResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func fetchThemeList() -> AnyPublisher<[ThemeEntity], Error> {
        request(.fetchThemeList, dto: FetchThemeListResponseDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
