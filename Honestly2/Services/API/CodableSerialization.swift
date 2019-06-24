import Foundation

extension Data {
    func deserialize<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}

extension Encodable {
    func serialize() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
            let serializedObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            else { return nil }
        return serializedObject
    }
}
