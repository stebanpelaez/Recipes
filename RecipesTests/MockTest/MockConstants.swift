//
//  MockConstants.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

@testable import Recipes

enum MockConstants {

    static let responseCategories = [
        "categories": [
            [
                "idCategory": "1",
                "strCategory": "Beef",
                "strCategoryThumb": "https://www.themealdb.com/images/category/beef.png",
                "strCategoryDescription": "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]"
            ]
        ]
    ]

    static let category = CategoryItem(idCategory: "1", strCategory: "Beef", strCategoryThumb: "", strCategoryDescription: "")
    static let category2 = CategoryItem(idCategory: "2", strCategory: "Chicken", strCategoryThumb: "", strCategoryDescription: "")
    static let categories = [category, category2]
    static let categoriesList = CategoryList(categories: categories)

    static let meal = Meal(strMeal: "Beef", strMealThumb: "", idMeal: "1")
    static let meal2 = Meal(strMeal: "Beef 2", strMealThumb: "", idMeal: "2")
    static let meals = [meal, meal2]
    static let mealList = MealsList(meals: meals)
    
    static let detailList = DetailMeals(meals: [[ "strInstructions": "Preheat oven to 350F. Spray a 9x13-inch baking pan with non-stick spray.", "strIngredient1": "soy sauce",
                                                  "strIngredient2": "water",
                                                  "strMeasure1": "1",
                                                  "strMeasure2": "1"]])
}
