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

        container.register(CommentRepository.self) { resolver in
            CommentRepositoryImpl(remoteCommentDataSource: resolver.resolve(RemoteCommentDataSource.self)!)
        }

        container.register(ShopRepository.self) { resolver in
            ShopRepositoryImpl(remoteShopDataSource: resolver.resolve(RemoteShopDataSource.self)!)
        }

        container.register(MissionRepository.self) { resolver in
            MissionRepositoryImpl(remoteMissionDataSource: resolver.resolve(RemoteMissionDataSource.self)!)
        }

        container.register(AnalysisRepository.self) { resolver in
            AnalysisRepositoryImpl(remoteAnalysisDataSource: resolver.resolve(RemoteAnalysisDataSource.self)!)
        }
    }
}
