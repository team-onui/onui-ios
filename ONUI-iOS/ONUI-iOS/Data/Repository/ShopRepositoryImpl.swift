import Foundation
import Combine

struct ShopRepositoryImpl: ShopRepository {
    private let remoteShopDataSource: any RemoteShopDataSource

    init(remoteShopDataSource: any RemoteShopDataSource) {
        self.remoteShopDataSource = remoteShopDataSource
    }

    func buyTheme(theme: ThemeType) -> AnyPublisher<[ThemeEntity], Error> {
        remoteShopDataSource.buyTheme(theme: theme)
    }

    func fetchThemeList() -> AnyPublisher<[ThemeEntity], Error> {
        remoteShopDataSource.fetchThemeList()
    }
}
