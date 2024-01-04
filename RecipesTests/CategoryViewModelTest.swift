//
//  CategoryViewModelTest.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import XCTest

@testable import Recipes

final class CategoryViewModelTest: XCTestCase {

    private var categoryViewModel: ICategoryViewModel?
    private var mockService = MockAPIService()

    override func setUp() {
        super.setUp()
        categoryViewModel = CategoryViewModel(apiService: self.mockService)
    }

    override func tearDown() {
        super.tearDown()
        categoryViewModel = nil
    }

    func testListCategoriesFromService() {
        let category = expectation(description: "Get categories from service")
        mockService.typeResponse = .categories

        categoryViewModel?.reloadCollectionView = {
            XCTAssertTrue(self.categoryViewModel?.numberOfCells == MockConstants.categories.count)
            XCTAssertEqual(self.categoryViewModel?.getCategory(at: 0).idCategory, MockConstants.category.idCategory)
            category.fulfill()
        }

        categoryViewModel?.listCategoriesFromService()
        wait(for: [category], timeout: 3.0)
    }

}
