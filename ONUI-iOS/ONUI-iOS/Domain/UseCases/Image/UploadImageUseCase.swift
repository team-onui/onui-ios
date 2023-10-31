import Combine
import Foundation

struct UploadImageUseCase {
    private let imageRepository: any ImageRepository

    init(imageRepository: any ImageRepository) {
        self.imageRepository = imageRepository
    }

    func execute(data: Data, fileName: String) -> AnyPublisher<String, Error> {
        imageRepository.uploadImage(data: data, fileName: fileName)
    }
}
