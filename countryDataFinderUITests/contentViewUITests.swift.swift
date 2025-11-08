//
//  contentViewUITests.swift.swift
//  countryDataFinder
//
//  Created by Esraa Eldaltony on 08/11/2025.
//

import XCTest

final class ContentViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testSearchFieldExists() {
        let textField = app.textFields["countrySearchField"]
        XCTAssertTrue(textField.exists)
    }

    func testSearchCountryFlow() {
        let textField = app.textFields["countrySearchField"]
        XCTAssertTrue(textField.exists)

        textField.tap()
        textField.typeText("Egypt")
        
        // Give some time for API call
        sleep(3)
        
        // Look for the country name in the list or temporary view
        XCTAssert(app.staticTexts["Egypt"].exists)
    }
}
