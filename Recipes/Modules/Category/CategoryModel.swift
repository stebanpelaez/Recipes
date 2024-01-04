//
//  CategoryModel.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import Foundation

// MARK: - CategoryList
struct CategoryList: Codable {
    let categories: [CategoryItem]
}

// MARK: - Category
struct CategoryItem: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
