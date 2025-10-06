import Foundation

public final class SerpnodeClient {
    public struct Configuration {
        public let apiKey: String
        public let baseURL: URL
        public init(apiKey: String, baseURL: URL = URL(string: "https://api.serpnode.com")!) {
            self.apiKey = apiKey
            self.baseURL = baseURL
        }
    }

    private let configuration: Configuration
    private let urlSession: URLSession

    public init(configuration: Configuration, urlSession: URLSession = .shared) {
        self.configuration = configuration
        self.urlSession = urlSession
    }

    @available(iOS 15.0, macOS 12.0, *)
    public func search(params: [String: Any]) async throws -> [String: Any] {
        let url = configuration.baseURL.appendingPathComponent("search")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(configuration.apiKey, forHTTPHeaderField: "apikey")
        request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        let (data, response) = try await urlSession.data(for: request)
        try Self.validate(response: response)
        return try Self.json(from: data)
    }

    public func status(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let url = configuration.baseURL.appendingPathComponent("status")
        var request = URLRequest(url: url)
        request.setValue(configuration.apiKey, forHTTPHeaderField: "apikey")
        urlSession.dataTask(with: request) { data, response, error in
            if let error = error { return completion(.failure(error)) }
            do {
                guard let data = data, let response = response else { throw NSError(domain: "Serpnode", code: -1) }
                try Self.validate(response: response)
                completion(.success(try Self.json(from: data)))
            } catch { completion(.failure(error)) }
        }.resume()
    }

    private static func validate(response: URLResponse) throws {
        if let http = response as? HTTPURLResponse, !(200..<300).contains(http.statusCode) {
            throw NSError(domain: "Serpnode", code: http.statusCode)
        }
    }

    private static func json(from data: Data) throws -> [String: Any] {
        guard let obj = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { throw NSError(domain: "Serpnode", code: -2) }
        return obj
    }
}


