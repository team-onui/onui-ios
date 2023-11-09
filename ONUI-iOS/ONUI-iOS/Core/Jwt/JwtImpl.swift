import Foundation
import SwiftKeychainWrapper

public struct KeychainImpl: Keychain {
    public init() {}

    public func save(type: KeychainType, value: String) {
        KeychainWrapper.standard.set(value, forKey: type.rawValue)
    }

    public func load(type: KeychainType) -> String {
        KeychainWrapper.standard.string(forKey: type.rawValue) ?? ""
    }

    public func delete(type: KeychainType) {
        KeychainWrapper.standard.removeObject(forKey: type.rawValue)

    }
}
