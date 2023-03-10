import Foundation

public protocol Payload: BytesRepresentable {}

extension Payload {
    init? (encoded: String) {
        guard let data = Bytes(fromBase64: encoded) else { return nil }
        self.init(bytes: data)
    }

    var encode: String { return self.toBase64 }
}
