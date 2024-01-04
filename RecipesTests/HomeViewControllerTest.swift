//
//  HomeViewControllerTests.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import XCTest
@testable import Recipes

class HomeViewControllerTests: XCTestCase {

    private var sut: HomeViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "homeViewController") as? HomeViewController else {
            XCTFail("Could not instantiate viewController as HomeViewController")
            return
        }

        sut = viewController
        sut.viewModel = MockHomeViewModel()

        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testListMeals() {

        let expectation = expectation(description: "Expectation from result")

        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 4.0)

        XCTAssertTrue(sut.viewModel?.numberOfCells ?? 0 > 0)
        XCTAssertTrue(!sut.labelEmpty.isHidden)
    }

}
