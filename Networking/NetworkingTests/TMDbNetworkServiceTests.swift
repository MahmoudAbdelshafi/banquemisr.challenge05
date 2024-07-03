//
//  TMDbNetworkServiceTests.swift
//  NetworkingTests
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import XCTest
import Combine
@testable import Networking
import Foundation

class TMDbNetworkServiceTests: XCTestCase {
    
    var service: NetworkService!
    let mockEndpoint = MockNetworkEndPoints.mockEndpoint
    
    override func setUp() {
        super.setUp()
        service = TMDbNetworkService()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func testFetch_SuccessfulRequest() {
        let expectation = XCTestExpectation(description: "Fetch should succeed")
        
        var cancellable: AnyCancellable?
        cancellable = service.fetch(endpoint: mockEndpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    debugPrint("Request URL: \(error)")
                    XCTFail("Request failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { (response: MockAPIBaseResponse) in
                // Assert on response if needed
            })
        
        wait(for: [expectation], timeout: 5.0)
        cancellable?.cancel()
    }
    
    func testFetch_WrongResponse() {
        let badEndpoint = MockNetworkEndPoints.mockEndpoint
        let expectation = XCTestExpectation(description: "Fetch should fail with decodingError error")
        
        var cancellable: AnyCancellable?
        cancellable = service.fetch(endpoint: badEndpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Request should fail with bad URL error")
                case .failure(let error):
                    XCTAssertEqual(error, NetworkError.decodingError)
                    expectation.fulfill()
                }
            }, receiveValue: { (response: String) in
                XCTFail("Request should not receive value on decodingError")
            })
        
        wait(for: [expectation], timeout: 5.0)
        cancellable?.cancel()
    }
}
