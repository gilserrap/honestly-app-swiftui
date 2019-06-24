import Foundation

class URLRequestBuilder {
    class func build(for service: APIService, with parameters: [String: Any]) -> URLRequest {
        let fullPath = service.baseURLString + service.path
        var request: URLRequest!
        if service.method == .get {
            var components = URLComponents(string: fullPath)!
            components.queryItems = parameters.compactMap { (arg) -> URLQueryItem? in
                switch arg {
                case let (key, value) as (String, String):
                    return URLQueryItem(name: key, value: value)
                case let (key, value) as (String, Double):
                    return URLQueryItem(name: key, value: String(value))
                case let (key, value) as (String, Int):
                    return URLQueryItem(name: key, value: String(value))
                default:
                    return nil
                }
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            request =  URLRequest(url: components.url!)
        } else {
            request = URLRequest(url: URL(string: fullPath)!)
            request!.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        request.httpMethod = service.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }
}
