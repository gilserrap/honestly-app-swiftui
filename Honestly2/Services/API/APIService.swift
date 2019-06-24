import Foundation
import Combine

enum APIService {

    case message(Method)
    case keywords(Method)

    var pathData: (String, Method) {
        switch self {
        case .message(let method):
            return ("/message", method)
        case .keywords(let method):
            return ("/keywords", method)
        }
    }
}

extension APIService {

    enum Method: String {
        case post = "POST"
        case get = "GET"
    }

    var baseURLString: String {
        return ""
    }

    var path: String {
        return pathData.0
    }

    var method: Method {
        return pathData.1
    }

    func request<T: Codable>(with object : T? = nil) throws -> AnyPublisher<Data, Never> {
        let parameters = object?.serialize()
        return request(with: parameters)
    }

    func request<T: Codable>(with object: T? = nil) throws -> AnyPublisher<T, Never> {
        let parameters = object?.serialize()
        return request(with: parameters).compactMap { data -> T? in
            return data.deserialize()
        }.eraseToAnyPublisher()
    }

    func request(with parameters: [String: Any]? = nil) -> AnyPublisher<Data, Never> {
        let request = URLRequestBuilder.build(for: self, with: parameters ?? [:])
        return URLSession.shared.dataTaskPublisher(for: request).map { data, response in
            return data
        }
        .assertNoFailure()
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }

    func observe<T: Codable>() -> ObserveApiPublisher<T> {
        return ObserveApiPublisher(service: self)
    }
}
