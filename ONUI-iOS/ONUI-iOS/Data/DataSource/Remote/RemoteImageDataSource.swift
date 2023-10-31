import Combine
import Foundation

protocol RemoteImageDataSource {
    func uploadImage(data: Data, fileName: String) -> AnyPublisher<String, Error>
}

final class RemoteImagedataSourceImpl: BaseRemoteDataSource<ImageAPI>, RemoteImageDataSource {
    func uploadImage(data: Data, fileName: String) -> AnyPublisher<String, Error> {
        request(.uploadImage(data: data, fileName: fileName), dto: UploadImageResponseDTO.self)
            .map { $0.url }
            .eraseToAnyPublisher()
    }
}
