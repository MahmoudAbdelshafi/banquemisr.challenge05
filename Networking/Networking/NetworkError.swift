//
//  NetworkError.swift
//  Networking
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case badURL
    case requestFailed
    case decodingError
    case unknown
    case error(statusCode: Int, data: Data?, message: String?)
    
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return "The URL is invalid."
        case .requestFailed:
            return "The request failed."
        case .decodingError:
            return "Failed to decode the response."
        case .unknown:
            return "An unknown error occurred."
        case .error(let statusCode, _, let message):
            return "Error \(statusCode): \(message ?? "Unknown error")"
        }
    }
  
}

//MARK: - Conforming to Equatable for Testing Usage

extension NetworkError: Equatable {
    
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.badURL, .badURL), (.requestFailed, .requestFailed), (.decodingError, .decodingError), (.unknown, .unknown):
            return true
        case (.error(let lhsStatusCode, _, let lhsMessage), .error(let rhsStatusCode, _, let rhsMessage)):
            return lhsStatusCode == rhsStatusCode && lhsMessage == rhsMessage
        default:
            return false
        }
    }
    
}
