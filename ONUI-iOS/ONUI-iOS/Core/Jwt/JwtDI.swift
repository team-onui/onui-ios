import Foundation
import Swinject

public final class KeychainDI: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(Keychain.self) { _ in
            KeychainImpl()
        }
    }
}
