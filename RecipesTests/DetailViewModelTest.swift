//
//  DetailViewModelTest.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import XCTest

@testable import Recipes

final class DetailViewModelTest: XCTestCase {

    private var detailViewModel: IDetailViewModel?
    private var mockService = MockAPIService()

    override func setUp() {
        super.setUp()
        detailViewModel = DetailViewModel(apiService: self.mockService)
    }

    override func tearDown() {
        super.tearDown()
        detailViewModel = nil
    }

    func testListCategoriesFromService() {
        let detail = expectation(description: "Get detail meal")
        mockService.typeResponse = .detail

        detailViewModel?.meal = Meal(strMeal: "Chicken", strMealThumb: "", idMeal: "1")
        _ = detailViewModel?.getInstructions()

        detailViewModel?.reloadDetailUI = {
            XCTAssertFalse(self.detailViewModel?.getIngrendients().isEmpty ?? true)
            XCTAssertFalse(self.detailViewModel?.getInstructions().isEmpty ?? true)
            detail.fulfill()
        }

        detailViewModel?.detailFullMealFromService()
        wait(for: [detail], timeout: 3.0)
    }

}
