//
//  NetworkService.swift
//  Networking
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation
import Combine

public protocol NetworkService {
    func fetch<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, NetworkError>
}

public class TMDbNetworkService: NetworkService {
    
    public init() {}
    
    public func fetch<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        debugPrint(request)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                let response = result.response as? HTTPURLResponse
                
                if let response = response, !(200...299).contains(response.statusCode) {
                    // Attempt to decode error response
                    if let errorResponse = try? JSONDecoder().decode(TMDbErrorResponse.self, from: result.data) {
                        throw NetworkError.error(statusCode: response.statusCode, data: result.data, message: errorResponse.statusMessage)
                    } else {
                        throw NetworkError.error(statusCode: response.statusCode, data: result.data, message: nil)
                    }
                }
                
                return result.data
            }
            .handleEvents(receiveOutput: { output in
                if let json = try? JSONSerialization.jsonObject(with: output, options: .mutableContainers),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    debugPrint("Received data: \(jsonString)")
                } else {
                    debugPrint("Received data could not be serialized to JSON")
                }
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if let decodingError = error as? DecodingError {
                    return .decodingError
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}

struct TMDbErrorResponse: Decodable {
    let statusMessage: String
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}

