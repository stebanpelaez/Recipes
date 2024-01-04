//
//  BaseViewModel.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import Foundation

typealias HandlerCompletion = (() -> Void)

protocol IBaseViewModel: AnyObject {
    // Intentionally unimplemented...
}

class BaseViewModel: IBaseViewModel {

    let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }

}
