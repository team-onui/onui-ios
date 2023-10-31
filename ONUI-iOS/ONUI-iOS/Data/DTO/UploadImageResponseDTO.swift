import Foundation

struct UploadImageResponseDTO: Decodable {
    var url: String

    init(url: String) {
        self.url = url
    }
}
