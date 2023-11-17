import Foundation

struct FetchThemeListResponseDTO: Decodable {
    let themeList: [ThemeWithPriceResponseDTO]?
    
    enum CodingKeys: String, CodingKey {
        case themeList = "theme_list"
    }
}

struct ThemeWithPriceResponseDTO: Decodable {
    let theme: ThemeType
    let price: Int
    let isBought: Bool
    
    enum CodingKeys: String, CodingKey {
        case theme
        case price
        case isBought = "is_bought"
    }
}

extension FetchThemeListResponseDTO {
    func toDomain() -> [ThemeEntity] {
        guard let themeList else { return [] }
        return themeList.map { $0.toDomain() }
    }
}

extension ThemeWithPriceResponseDTO {
    func toDomain() -> ThemeEntity {
        ThemeEntity(theme: theme.toDomain(), price: price, isBought: isBought)
    }
}
