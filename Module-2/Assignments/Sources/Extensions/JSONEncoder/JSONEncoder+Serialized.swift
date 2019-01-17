import Foundation

extension JSONEncoder {

    func serialized<T: Encodable>(_ encodable: T?) -> [String: Any]? {
        return encodable
            .flatMap { try? encode($0) }
            .flatMap { try? JSONSerialization.jsonObject(with: $0) }
            .flatMap { $0 as? [String: Any] }
    }

}
