//
//  CategoryViewControllerTests.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import XCTest
@testable import Recipes

class CategoryViewControllerTests: XCTestCase {

    private var sut: CategoryViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "categoryViewController") as? CategoryViewController else {
            XCTFail("Could not instantiate viewController as CategoryViewController")
            return
        }
        sut = viewController
        sut.viewModel = MockCategoryViewModel()

        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testCategory() {

        let expectation = expectation(description: "Expectation categories")

        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 4.0)

        XCTAssertTrue(sut.viewModel?.numberOfCells ?? 0 > 0)
    }

}
