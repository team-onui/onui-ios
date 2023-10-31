import Foundation

struct RenameRequestQuery: Encodable {
    let name: String

    init(name: String) {
        self.name = name
    }
}
