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
            .handleEvents(receiveOutput: { output in
                if let json = try? JSONSerialization.jsonObject(with: output.data, options: .mutableContainers),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    debugPrint("Received data: \(jsonString)")
                } else {
                    debugPrint("Received data could not be serialized to JSON")
                }
            })
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case is URLError:
                    return .requestFailed
                case is DecodingError:
                    return .decodingError
                default:
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}

