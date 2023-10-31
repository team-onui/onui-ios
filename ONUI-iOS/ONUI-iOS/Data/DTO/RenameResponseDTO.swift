import Foundation

struct RenameResponseDTO: Decodable {
    var name: String

    init(name: String) {
        self.name = name
    }
}

extension RenameResponseDTO {
    func toDomain() -> String { name }
}
