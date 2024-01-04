//
//  MockAPIService.swift
//  RecipesTests
//
//  Created by Brahyam Pineda Cardona on 3/01/24.
//

import Foundation
@testable import Recipes

enum TypeResponseService {
    case home
    case homeEmpty
    case categories
    case detail
}

class MockAPIService: APIServiceProtocol {

    var typeResponse: TypeResponseService = .home

    func consumeAPIEndpoint<T: Codable>(request: Recipes.APIRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        switch self.typeResponse {
        case .home:
            if let mealList = MockConstants.mealList as? T {
                completion(.success(mealList))
            }
        case .homeEmpty:
            if let emptyList = MealsList(meals: []) as? T {
                completion(.success(emptyList))
            }
        case .categories:
            if let categorieList = MockConstants.categoriesList as? T {
                completion(.success(categorieList))
            }
        case .detail:
            if let detailList = MockConstants.detailList as? T {
                completion(.success(detailList))
            }
        }
    }

}
