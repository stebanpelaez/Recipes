//
//  APIService+Extension.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//
import Foundation

enum APIError: Swift.Error {
    case invalidURL
    case httpCode(Int)
    case unexpectedResponse
    case errorBody
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .errorBody: return "Error in body"
        }
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}

enum HTTPHeader {
    static let authorization = "Authorization"
    static let contentType = "Content-Type"
    static let accept = "Accept"

    static let applicationJson = "application/json;charset=UTF-8"
    static let urlEncoded = "application/x-www-form-urlencoded"
}

enum Constants: String {
    case urlBase = "https://www.themealdb.com/api/json/v1/1/"
    case endPointCategories = "categories.php"
    case endPointMeals = "filter.php"
    case endPointFullDetail = "lookup.php"
}
