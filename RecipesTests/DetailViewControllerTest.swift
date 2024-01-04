//
//  DetailViewControllerTests.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import XCTest
@testable import Recipes

class DetailViewControllerTests: XCTestCase {

    private var sut: DetailViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "detailViewController") as? DetailViewController else {
            XCTFail("Could not instantiate viewController as DetailViewController")
            return
        }

        sut = viewController

        sut.viewModel = MockDetailViewModel()

        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testDetailMeal() {

        let expectation = expectation(description: "Expectation from not result")

        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 4.0)

        XCTAssertNotNil(sut.viewModel?.getIngrendients())
    }

}
