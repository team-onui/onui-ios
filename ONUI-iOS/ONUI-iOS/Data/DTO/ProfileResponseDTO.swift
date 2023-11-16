import Foundation

struct ProfileResponseDTO: Decodable {
    let sub: String
    let name: String
    let profileTheme: String
    let theme: ThemeType
    let onFiltering: Bool

    enum CodingKeys: String, CodingKey {
        case sub, name, theme
        case onFiltering = "on_filtering"
        case profileTheme = "profile_theme"
    }
}

extension ProfileResponseDTO {
    func toDomain() -> ProfileEntity {
        ProfileEntity(sub: sub, name: name, profileTheme: profileTheme, theme: theme, onFiltering: onFiltering)
    }
}
