//
//  NetworkService.swift
//  Networking
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation
import Combine
import os

public protocol NetworkService {
    func fetch<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, NetworkError>
}

public class TMDbNetworkService: NetworkService {
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "co.mahmoud.TMDB", category: "networking")
    
    public init() {}
    
    public func fetch<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
        guard let request = buildRequest(for: endpoint) else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                try self.handleResponse(result)
            }
            .handleEvents(receiveOutput: { output in
                self.logResponseData(output)
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { self.mapError($0) }
            .eraseToAnyPublisher()
    }
    
    private func buildRequest(for endpoint: Endpoint) -> URLRequest? {
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            return nil
        }
        components.queryItems = endpoint.queryItems
        guard let url = components.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
    
    private func handleResponse(_ result: URLSession.DataTaskPublisher.Output) throws -> Data {
        let response = result.response as? HTTPURLResponse
        if let response = response, !(200...299).contains(response.statusCode) {
            if let errorResponse = try? JSONDecoder().decode(NetworkServiceErrorResponse.self, from: result.data) {
                throw NetworkError.error(statusCode: response.statusCode, data: result.data, message: errorResponse.statusMessage)
            } else {
                throw NetworkError.error(statusCode: response.statusCode, data: result.data, message: nil)
            }
        }
        return result.data
    }
    
    private func logResponseData(_ data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            logger.debug("Received data: \(jsonString)")
        } else {
            logger.debug("Received data could not be serialized to JSON")
        }
    }
    
    private func mapError(_ error: Error) -> NetworkError {
        if let networkError = error as? NetworkError {
            return networkError
        } else if let decodingError = error as? DecodingError {
            return .decodingError
        } else if (error as NSError).domain == NSURLErrorDomain {
            switch (error as NSError).code {
            case NSURLErrorNotConnectedToInternet:
                return .noInternet
            case NSURLErrorTimedOut:
                return .timeout
            default:
                return .requestFailed
            }
        } else {
            return .unknown
        }
    }
}


struct NetworkServiceErrorResponse: Decodable {
    let statusMessage: String
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}

