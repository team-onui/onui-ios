import Combine

struct BuyThemeUseCase {
    private let shopRepository: any ShopRepository

    init(shopRepository: any ShopRepository) {
        self.shopRepository = shopRepository
    }

    func execute(theme: ThemeType) -> AnyPublisher<[ThemeEntity], Error> {
        shopRepository.buyTheme(theme: theme)
    }
}
