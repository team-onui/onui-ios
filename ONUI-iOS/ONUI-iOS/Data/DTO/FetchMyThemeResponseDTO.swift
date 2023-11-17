import Foundation

struct FetchMyThemeResponseDTO: Decodable {
    let themeList: [ThemeResponseDTO]?
    
    enum CodingKeys: String, CodingKey {
        case themeList = "theme_list"
    }
}

struct ThemeResponseDTO: Decodable {
    let theme: ThemeType
}

extension FetchMyThemeResponseDTO {
    func toDomain() -> [Theme] {
        guard let themeList else { return [] }
        return themeList.map { $0.toDomain() }
    }
}

extension ThemeResponseDTO {
    func toDomain() -> Theme {
        theme.toDomain()
    }
}
