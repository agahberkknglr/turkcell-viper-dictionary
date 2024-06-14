//
//  DictionaryUITests.swift
//  DictionaryUITests
//
//  Created by Agah Berkin Güler on 7.06.2024.
//

import XCTest

final class DictionaryUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_searchFunctionality() {
        app.launch()
        
        sleep(2)
        
        let searchBar = app.otherElements["searchBar"]
        XCTAssertTrue(searchBar.exists, "The search bar does not exist.")
        
        searchBar.tap()
        searchBar.typeText("Test")
        
        let searchButton = app.buttons["searchButton"]
        XCTAssertTrue(searchButton.exists, "The search button does not exist.")
        searchButton.tap()
        
        let wordTitleLabel = app.staticTexts["wordTitleLabel"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: wordTitleLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(wordTitleLabel.exists, "The detail page did not load.")
        
        let wordAudioButton = app.buttons["wordAudioButton"]
        XCTAssertTrue(wordAudioButton.exists, "The word audio button does not exist.")
        wordAudioButton.tap()
        
        let filterCollectionView = app.collectionViews["filterCollectionView"]
        XCTAssertTrue(filterCollectionView.exists, "The filter collection view does not exist.")
        filterCollectionView.swipeUp()
        
        let firstFilterCell = filterCollectionView.cells.element(boundBy: 0)
        XCTAssertTrue(firstFilterCell.exists, "The first cell in the filter collection view does not exist.")
        firstFilterCell.tap()
        
        app.swipeUp()
        
        let synonymCollectionView = app.collectionViews["synonymCollectionView"]
        XCTAssertTrue(synonymCollectionView.exists, "The synonym collection view does not exist.")
        
        while !synonymCollectionView.frame.intersects(app.frame) {
            app.swipeUp()
        }
        
        let firstSynonymCell = synonymCollectionView.cells.element(boundBy: 0)
        XCTAssertTrue(firstSynonymCell.exists, "The first cell in the synonym collection view does not exist.")
        firstSynonymCell.tap()
        
        let synonymTitleLabel = app.staticTexts["wordTitleLabel"]
        let existsSynonym = NSPredicate(format: "exists == 1")
        expectation(for: existsSynonym, evaluatedWith: synonymTitleLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(synonymTitleLabel.exists, "The detail page did not load.")

                
    }
}
