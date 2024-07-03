//
//  NetworkConfiguration.swift
//  Data
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation

enum ConfigurationError: Error, LocalizedError {
    case missingKey(String)

    var errorDescription: String? {
        switch self {
        case .missingKey(let key):
            return "\(key) must not be empty in plist"
        }
    }
}

final class NetworkAppConfiguration {
    
    static let shared = NetworkAppConfiguration()
    
    private let bundle: Bundle
    
    // Private init for singleton
    private init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
    
    // Public init for testing
    public init(testingBundle: Bundle) {
        self.bundle = testingBundle
    }
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = bundle.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    
    lazy var apiKey: String = {
        guard let apiKey = bundle.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    func getApiBaseURL() throws -> String {
        guard let apiBaseURL = bundle.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            throw ConfigurationError.missingKey("ApiBaseURL")
        }
        return apiBaseURL
    }
    
    func getApiKey() throws -> String {
        guard let apiKey = bundle.object(forInfoDictionaryKey: "ApiKey") as? String else {
            throw ConfigurationError.missingKey("ApiKey")
        }
        return apiKey
    }
}
