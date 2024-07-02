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
    case error(statusCode: Int, data: Data?)
    case generic(Error)
}
