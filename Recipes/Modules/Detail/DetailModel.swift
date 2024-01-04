//
//  DetailModel.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import Foundation

// MARK: - Meals
struct DetailMeals: Codable {
    let meals: [[String: String?]]
}

enum KeyMeal: String {
    case idMeal
    case strMeal
    case strCategory
    case strArea
    case strInstructions
    case strMealThumb
    case strYoutube
    case strIngredient
    case strMeasure
}
