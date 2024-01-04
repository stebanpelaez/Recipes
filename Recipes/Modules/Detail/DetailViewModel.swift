//
//  DetailViewModel.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import Foundation

protocol IDetailViewModel: IBaseViewModel {
    var meal: Meal? { get set }
    var reloadDetailUI: HandlerCompletion? { get set }
    func detailFullMealFromService()
    func getIngrendients() -> String
    func getInstructions() -> String
}

class DetailViewModel: BaseViewModel, IDetailViewModel {

    var meal: Meal?

    private var detailMeal: [String: String?] = [:] {
        didSet {
            self.reloadDetailUI?()
        }
    }

    var reloadDetailUI: HandlerCompletion?

    // Obtener información completa de la receta
    func detailFullMealFromService() {

        guard let idMeal = self.meal?.idMeal else { return }

        let params = ["i": idMeal]

        let request = APIRequestBuilder(urlApi: Constants.urlBase.rawValue)
            .withMethod(.get)
            .withEndPoint(Constants.endPointFullDetail.rawValue)
            .withParams(params)
            .build()

        self.apiService.consumeAPIEndpoint(request: request, type: DetailMeals.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.detailMeal = response.meals.first ?? [:]
            case .failure(let error):
                self?.detailMeal = [:]
                print(error.localizedDescription)
            }
        }
    }

    // Obtener propiedades de la receta
    func getIngrendients() -> String {
        var instructions = ""
        for it in 1...20 {
            if let iValue = self.detailMeal["\(KeyMeal.strIngredient.rawValue)\(it)"],
                let iValue2 = iValue?.trimmingCharacters(in: .whitespacesAndNewlines), !iValue2.isEmpty,
                let mValue = self.detailMeal["\(KeyMeal.strMeasure.rawValue)\(it)"],
                   let mValue2 = mValue?.trimmingCharacters(in: .whitespacesAndNewlines), !mValue2.isEmpty {
                instructions += "• \(mValue2) \(iValue2)\n"
            }
        }
        return instructions
    }

    func getInstructions() -> String {
        let instructions = self.detailMeal[KeyMeal.strInstructions.rawValue] ?? ""
        return instructions ?? ""
    }

}
