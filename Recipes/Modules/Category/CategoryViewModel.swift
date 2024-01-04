//
//  CategoryViewModel.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import Foundation

protocol ICategoryViewModel: IBaseViewModel {
    var numberOfCells: Int { get }
    var reloadCollectionView: HandlerCompletion? { get set }
    func listCategoriesFromService()
    func getCategory(at index: Int) -> CategoryItem
}

class CategoryViewModel: BaseViewModel, ICategoryViewModel {

    private var items: [CategoryItem] = [CategoryItem]()

    var numberOfCells: Int {
        return self.items.count
    }

    var reloadCollectionView: HandlerCompletion?

    // Se traen todas las recetas por categoria, se invoca el servicio
    func listCategoriesFromService() {

        let request = APIRequestBuilder(urlApi: Constants.urlBase.rawValue)
            .withMethod(.get)
            .withEndPoint(Constants.endPointCategories.rawValue)
            .build()

        self.apiService.consumeAPIEndpoint(request: request, type: CategoryList.self) { [weak self] result in
            switch result {
            case .success(let categories):
                self?.items = categories.categories
                self?.reloadCollectionView?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getCategory(at index: Int) -> CategoryItem {
        return self.items[index]
    }

}
