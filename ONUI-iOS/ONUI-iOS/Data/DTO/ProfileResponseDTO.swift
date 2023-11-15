import Foundation

struct ProfileResponseDTO: Decodable {
    let sub: String
    let name: String
    let theme: String
    let onFiltering: Bool

    enum CodingKeys: String, CodingKey {
        case sub, name, theme
        case onFiltering = "on_filtering"
    }
}

extension ProfileResponseDTO {
    func toDomain() -> ProfileEntity {
        ProfileEntity(sub: sub, name: name, theme: theme, onFiltering: onFiltering)
    }
}
