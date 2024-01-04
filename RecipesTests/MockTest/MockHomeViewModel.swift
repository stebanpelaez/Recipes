//
//  MockHomeViewModel.swift
//  RecipesTests
//
//  Created by Brahyam Pineda Cardona on 3/01/24.
//

import Foundation
@testable import Recipes

class MockHomeViewModel: IHomeViewModel {

    var category: CategoryItem? = MockConstants.category

    var numberOfCells: Int = 1

    var reloadTableView: HandlerCompletion?
    var showNoResultsFound: HandlerCompletion?

    func listMealsFromCategory() {
        showNoResultsFound?()
        reloadTableView?()
    }

    func getMeal(at index: Int) -> Meal {
        return MockConstants.meal
    }

    func filterMeal(searchText: String) {

    }

    func resetFilter() {

    }

}
