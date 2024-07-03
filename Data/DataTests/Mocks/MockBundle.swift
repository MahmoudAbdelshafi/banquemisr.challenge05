//
//  MockBundle.swift
//  DataTests
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation

class MockBundle: Bundle {
    private let mockInfoDictionary: [String: Any]
    
    init(mockInfoDictionary: [String: Any]) {
        self.mockInfoDictionary = mockInfoDictionary
        super.init()
    }
    
    override func object(forInfoDictionaryKey key: String) -> Any? {
        return mockInfoDictionary[key]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
