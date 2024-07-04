//
//  PopularViewUITests.swift
//  PresentaionUITests
//
//  Created by Mahmoud Abdelshafi on 03/07/2024.
//

import XCTest

class PopularViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        
        // Configure the path to your main application target
        app = XCUIApplication(bundleIdentifier: "co.mahmoud.TMDB")
        app.launchArguments.append("--uitesting") // Example launch argument for UI testing setup
        
        app.launch() // Launch the app
    }

    func testPopularViewListDisplays() {
        // Given
        let collectionView = app.collectionViews["movieList"]
        
        // When
        let popularButton = app.buttons["Popular"]
        popularButton.tap()
        
        // Then
        XCTAssertTrue(collectionView.waitForExistence(timeout: 10.0), "CollectionView should exist")
        
        // Verify that there's at least one MovieRow in the collectionView
      
        let buttons = collectionView.buttons.matching(identifier: "MovieRow")
        XCTAssertTrue(buttons.count > 0, "At least one MovieRow should exist as a button")
    }
    
    func testNavigateToMovieDetailsView() {
        // When
        let popularButton = app.buttons["Popular"]
        popularButton.tap()
        
        // Given
        let collectionView = app.collectionViews["movieList"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 10.0), "collectionView should exist")
        
        // When
        if !collectionView.cells["MovieRow"].exists {
            collectionView.swipeUp()
        }
        
        let movieRow = collectionView.buttons.matching(identifier: "MovieRow").firstMatch
        XCTAssertTrue(movieRow.waitForExistence(timeout: 10.0), "MovieRow should exist")
        
        // When
        movieRow.tap()
       
        // Then
        let movieDetailsView = app.scrollViews["MovieDetailsView"]
        XCTAssertTrue(movieDetailsView.waitForExistence(timeout: 10.0), "MovieDetailsView should appear after tapping MovieRow")
    }


    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
}
