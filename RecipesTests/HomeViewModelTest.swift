//
//  HomeViewModelTest.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import XCTest

@testable import Recipes

final class HomeViewModelTest: XCTestCase {

    private var homeViewModel: IHomeViewModel?
    private var mockService = MockAPIService()

    override func setUp() {
        super.setUp()
        homeViewModel = HomeViewModel(apiService: self.mockService)
    }

    override func tearDown() {
        super.tearDown()
        homeViewModel = nil
    }

    func testListCategoriesFromService() {
        let meals = expectation(description: "Get meals from service")
        mockService.typeResponse = .home

        homeViewModel?.category = MockConstants.category

        homeViewModel?.reloadTableView = {
            XCTAssertTrue(self.homeViewModel?.numberOfCells == MockConstants.meals.count)
            XCTAssertEqual(self.homeViewModel?.getMeal(at: 0).idMeal, MockConstants.meal.idMeal)

            meals.fulfill()
        }

        homeViewModel?.listMealsFromCategory()
        wait(for: [meals], timeout: 3.0)
    }

    func testListEmptyCategoriesFromService() {
        let meals = expectation(description: "Get meals empty from service")
        mockService.typeResponse = .home

        homeViewModel?.category = MockConstants.category
        homeViewModel?.resetFilter()
        homeViewModel?.filterMeal(searchText: "")

        homeViewModel?.reloadTableView = {
            XCTAssertTrue(self.homeViewModel?.numberOfCells == 0)
            meals.fulfill()
        }

        homeViewModel?.filterMeal(searchText: "Filter")

        wait(for: [meals], timeout: 3.0)
    }

}
