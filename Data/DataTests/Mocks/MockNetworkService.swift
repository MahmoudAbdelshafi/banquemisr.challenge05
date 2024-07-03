//
//  MockNetworkService.swift
//  DataTests
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation
import XCTest
import Combine
@testable import Data
import Networking

class MockNetworkService: NetworkService {
    var fetchResult: AnyPublisher<Any, NetworkError>?

    func fetch<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
        guard let result = fetchResult else {
            return Fail(error: .unknown).eraseToAnyPublisher()
        }
        
        return result
            .tryMap { data -> T in
                guard let decodedData = data as? T else {
                    throw NetworkError.decodingError
                }
                return decodedData
            }
            .mapError { error in
                error as? NetworkError ?? .unknown
            }
            .eraseToAnyPublisher()
    }
}
