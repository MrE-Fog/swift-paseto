import Foundation

public protocol Public {
    associatedtype AsymmetricSecretKey: Paseto.AsymmetricSecretKey
    associatedtype AsymmetricPublicKey: Paseto.AsymmetricPublicKey where
        AsymmetricPublicKey == AsymmetricSecretKey.Module.AsymmetricPublicKey

    associatedtype Public: Paseto.Public & Module where Public.Public == Public,
        AsymmetricSecretKey == Public.AsymmetricSecretKey

    static func sign(_: Package, with: AsymmetricSecretKey) throws -> Message<Public>

    static func verify(_: Message<Public>, with: AsymmetricPublicKey) throws -> Package
}

public extension Public {
    static func sign(
        _ data: BytesRepresentable,
        with key: AsymmetricSecretKey,
        footer: BytesRepresentable = Bytes()
    ) throws -> Message<Public> {
        return try sign(Package(data, footer: footer), with: key)
    }
}
