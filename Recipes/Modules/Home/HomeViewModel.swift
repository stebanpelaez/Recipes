//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import Foundation

protocol IHomeViewModel: IBaseViewModel {
    var category: CategoryItem? { get set }
    var numberOfCells: Int { get }
    var reloadTableView: HandlerCompletion? { get set }
    var showNoResultsFound: HandlerCompletion? { get set }
    func listMealsFromCategory()
    func getMeal(at index: Int) -> Meal
    func filterMeal(searchText: String)
    func resetFilter()
}

class HomeViewModel: BaseViewModel, IHomeViewModel {

    var category: CategoryItem?

    var numberOfCells: Int {
        return self.itemsFiltered.count
    }

    private var items: [Meal] = [Meal]()
    private var itemsFiltered: [Meal] = [Meal]()

    var reloadTableView: HandlerCompletion?
    var showNoResultsFound: HandlerCompletion?

    // Se traen todas las recetas por categoria, se invoca el servicio
    func listMealsFromCategory() {

        guard let category = self.category?.strCategory else { return }

        let params = ["c": category]

        let request = APIRequestBuilder(urlApi: Constants.urlBase.rawValue)
            .withMethod(.get)
            .withEndPoint(Constants.endPointMeals.rawValue)
            .withParams(params)
            .build()

        self.apiService.consumeAPIEndpoint(request: request, type: MealsList.self) { [weak self] result in
            switch result {
            case .success(let meals):
                self?.createCells(items: meals.meals)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getMeal(at index: Int) -> Meal {
        return self.itemsFiltered[index]
    }

    func filterMeal(searchText: String) {
        if !searchText.isEmpty {
            // En caso que se requiera filtrar por otra propiedad se agrega en este condicional
            self.itemsFiltered = self.items.filter { $0.strMeal.lowercased().contains(searchText) }
        } else {
            self.resetFilter()
        }
        self.reloadTableView?()
    }

    func resetFilter() {
        self.itemsFiltered = self.items
    }

    private func createCells(items: [Meal]) {
        self.items = items
        self.itemsFiltered = items
        if items.isEmpty {
            self.showNoResultsFound?()
        }
        self.reloadTableView?()
    }

}
