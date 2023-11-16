import Foundation

struct ProfileEntity: Equatable {
    let sub: String
    var name: String
    let profileTheme: String
    let theme: ThemeType
    let onFiltering: Bool
}
