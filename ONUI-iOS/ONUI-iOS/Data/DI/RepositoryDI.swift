import Foundation
import Swinject

public final class RepositoryDI: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(AuthRepository.self) { resolver in
            AuthRepositoryImpl(
                remoteAuthDataSource: resolver.resolve(RemoteAuthDataSource.self)!,
                localAuthDataSource: resolver.resolve(LocalAuthDataSource.self)!
            )
        }

        container.register(UserRepository.self) { resolver in
            UserRepositoryImpl(remoteUserDataSource: resolver.resolve(RemoteUserDataSource.self)!)
        }

        container.register(TimelineRepository.self) { resolver in
            TimelineRepositoryImpl(remoteTimelineDataSource: resolver.resolve(RemoteTimelineDataSource.self)!)
        }

        container.register(ImageRepository.self) { resolver in
            ImageRepositoryImpl(remoteImageDataSource: resolver.resolve(RemoteImageDataSource.self)!)
        }

        container.register(DiaryRepository.self) { resolver in
            DiaryRepositoryImpl(remoteDiaryDataSource: resolver.resolve(RemoteDiaryDataSource.self)!)
        }
    }
}
