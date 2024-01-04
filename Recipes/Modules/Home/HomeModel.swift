//
//  HomeModel.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import Foundation

// MARK: - Meals
struct MealsList: Codable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
