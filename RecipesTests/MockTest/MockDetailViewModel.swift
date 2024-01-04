//
//  MockDetailViewModel.swift
//  RecipesTests
//
//  Created by Brahyam Pineda Cardona on 3/01/24.
//

import Foundation
@testable import Recipes

class MockDetailViewModel: IDetailViewModel {

    var meal: Meal? = MockConstants.meal

    var reloadDetailUI: HandlerCompletion?

    func detailFullMealFromService() {
        self.reloadDetailUI?()
    }

    func getIngrendients() -> String {
        return ""
    }

    func getInstructions() -> String {
        return ""
    }

}
