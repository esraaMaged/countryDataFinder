//
//  countryViewModelTests.swift
//  countryDataFinder
//
//  Created by Esraa Eldaltony on 08/11/2025.
//

import XCTest
@testable import countryDataFinder

final class CountryViewModelTests: XCTestCase {
    var viewModel: CountryViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CountryViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testAddCountryToList() {
        let testCountry = CountryModel(
            name: "France",
            capital: "Paris",
            currencies: [
                Currency(code: "EUR", name: "Euro", symbol: "€")
            ],
            independent: true
        )
        viewModel.countries = [testCountry]

        XCTAssertEqual(viewModel.countries.count, 1)
        XCTAssertEqual(viewModel.countries.first?.name, "France")
    }

    func testFetchCountrySuccess() {
        let expectation = XCTestExpectation(description: "Fetch country by name")

        viewModel.fetchCountry(by: "France") { country in
            XCTAssertNotNil(country)
            XCTAssertEqual(country?.name, "France")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testErrorMessageIsNilInitially() {
        XCTAssertNil(viewModel.errorMessage)
    }
}
