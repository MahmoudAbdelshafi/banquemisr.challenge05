//
//  DataTests.swift
//  DataTests
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import XCTest
@testable import Data

final class NetworkAppConfigurationTests: XCTestCase {
    
    func testApiBaseURL() throws {
        let mockInfoDictionary: [String: Any] = ["ApiBaseURL": "https://api.example.com"]
        let mockBundle = MockBundle(mockInfoDictionary: mockInfoDictionary)
        
        let configuration = NetworkAppConfiguration(testingBundle: mockBundle)
        
        let apiBaseURL = try configuration.getApiBaseURL()
        
        XCTAssertEqual(apiBaseURL, "https://api.example.com", "ApiBaseURL should be 'https://api.example.com'")
    }
    
    func testApiKey() throws {
        let mockInfoDictionary: [String: Any] = ["ApiKey": "12345"]
        let mockBundle = MockBundle(mockInfoDictionary: mockInfoDictionary)
        
        let configuration = NetworkAppConfiguration(testingBundle: mockBundle)
        
        let apiKey = try configuration.getApiKey()
        
        XCTAssertEqual(apiKey, "12345", "ApiKey should be '12345'")
    }
    
    func testApiBaseURLMissing() {
        let mockInfoDictionary: [String: Any] = [:]
        let mockBundle = MockBundle(mockInfoDictionary: mockInfoDictionary)
        
        let configuration = NetworkAppConfiguration(testingBundle: mockBundle)
        
        XCTAssertThrowsError(try configuration.getApiBaseURL(), "ApiBaseURL should throw ConfigurationError.missingKey if missing") { error in
            XCTAssertEqual(error.localizedDescription, "ApiBaseURL must not be empty in plist")
        }
    }
    
    func testApiKeyMissing() {
        let mockInfoDictionary: [String: Any] = [:]
        let mockBundle = MockBundle(mockInfoDictionary: mockInfoDictionary)
        
        let configuration = NetworkAppConfiguration(testingBundle: mockBundle)
        
        XCTAssertThrowsError(try configuration.getApiKey(), "ApiKey should throw ConfigurationError.missingKey if missing") { error in
            XCTAssertEqual(error.localizedDescription, "ApiKey must not be empty in plist")
        }
    }
}
