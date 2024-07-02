//
//  NetworkConfiguration.swift
//  Data
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import Foundation

 final class NetworkAppConfiguration {
    
    static  let shared = NetworkAppConfiguration()
    
    private init() {}
    
     lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    
     lazy var apiKey: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiBaseURL
    }()
    
}
