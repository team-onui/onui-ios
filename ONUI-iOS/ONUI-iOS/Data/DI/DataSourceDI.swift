import Foundation
import Swinject

public final class DataSourceDI: Assembly {
    public init() {}

    private let keychain = { (resolver: Resolver) in
        resolver.resolve(Keychain.self)!
    }

    public func assemble(container: Container) {
        container.register(RemoteAuthDataSource.self) { resolver in
            RemoteAuthDataSourceImpl(keychain: self.keychain(resolver))
        }

        container.register(LocalAuthDataSource.self) { resolver in
            LocalAuthDataSourceImpl(keychain: self.keychain(resolver))
        }

        container.register(RemoteUserDataSource.self) { resolver in
            RemoteUserDataSourceImpl(keychain: self.keychain(resolver))
        }

        container.register(RemoteTimelineDataSource.self) { resolver in
            RemoteTimelineDataSourceImpl(keychain: self.keychain(resolver))
        }

        container.register(RemoteImageDataSource.self) { resolver in
            RemoteImageDataSourceImpl(keychain: self.keychain(resolver))
        }

        container.register(RemoteDiaryDataSource.self) { resolver in
            RemoteDiaryDataSourceImpl(keychain: self.keychain(resolver))
        }

        container.register(RemoteCommentDataSource.self) { resolver in
            RemoteCommentDataSourceImpl(keychain: self.keychain(resolver))
        }

        container.register(RemoteShopDataSource.self) { resolver in
            RemoteShopDataSourceImpl(keychain: self.keychain(resolver))
        }

        container.register(RemoteMissionDataSource.self) { resolver in
            RemoteMissionDataSourceImpl(keychain: self.keychain(resolver))
        }

        container.register(RemoteAnalysisDataSource.self) { resolver in
            RemoteAnalysisDataSourceImpl(keychain: self.keychain(resolver))
        }
    }
}
