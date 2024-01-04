//
//  DetailViewController.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import UIKit
import SDWebImage
import SkeletonView

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleMeal: UILabel!
    @IBOutlet weak var ingredientsMeal: UILabel!
    @IBOutlet weak var instructionsMeal: UILabel!

    var viewModel: IDetailViewModel? = DetailViewModel()

    @IBAction func openMap(_ sender: UIBarButtonItem) {
        let map = MapViewController()
        self.navigationController?.pushViewController(map, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initViewModel()
        self.updateBasicUI()
    }

}
// MARK: - Private Methods
extension DetailViewController {

    private func initViewModel() {
        self.viewModel?.reloadDetailUI = {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }

    // cargar campos basicos de UI y cargar detalle completo de la receta
    private func updateBasicUI() {
        self.imageView.sd_setImage(with: URL(string: self.viewModel?.meal?.strMealThumb ?? ""), placeholderImage: UIImage(), options: [], completed: nil)
        self.titleMeal.text = self.viewModel?.meal?.strMeal

        self.view.showAnimatedGradientSkeleton()

        self.viewModel?.detailFullMealFromService()
    }

    // Actualizar UI
    private func updateUI() {
        self.view.hideSkeleton()
        self.ingredientsMeal.text = self.viewModel?.getIngrendients()
        self.instructionsMeal.text = self.viewModel?.getInstructions()
    }

}
