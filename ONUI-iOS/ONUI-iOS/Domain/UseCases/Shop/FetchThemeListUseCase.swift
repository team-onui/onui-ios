import Combine

struct FetchThemeListUseCase {
    private let shopRepository: any ShopRepository

    init(shopRepository: any ShopRepository) {
        self.shopRepository = shopRepository
    }

    func execute() -> AnyPublisher<[ThemeEntity], Error> {
        shopRepository.fetchThemeList()
    }
}
