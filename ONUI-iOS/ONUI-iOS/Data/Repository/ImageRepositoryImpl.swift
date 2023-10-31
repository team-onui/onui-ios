import Foundation
import Combine

struct ImageRepositoryImpl: ImageRepository {
    private let remoteImageDataSource: any RemoteImageDataSource

    init(remoteImageDataSource: any RemoteImageDataSource) {
        self.remoteImageDataSource = remoteImageDataSource
    }

    func uploadImage(data: Data, fileName: String) -> AnyPublisher<String, Error> {
        remoteImageDataSource.uploadImage(data: data, fileName: fileName)
    }
}
