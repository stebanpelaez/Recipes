//
//  MockCategoryViewModel.swift
//  RecipesTests
//
//  Created by Brahyam Pineda Cardona on 4/01/24.
//

import Foundation
@testable import Recipes

class MockCategoryViewModel: ICategoryViewModel {

    var numberOfCells: Int = 1

    var reloadCollectionView: HandlerCompletion?

    func listCategoriesFromService() {
        reloadCollectionView?()
    }

    func getCategory(at index: Int) -> CategoryItem {
        return MockConstants.category
    }

}
