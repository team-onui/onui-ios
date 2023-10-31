import Combine
import Foundation

protocol ImageRepository {
    func uploadImage(data: Data, fileName: String) -> AnyPublisher<String, Error>
}
