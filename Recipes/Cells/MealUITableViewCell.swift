//
//  MealUITableViewCell.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import UIKit
import SDWebImage

class MealUITableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewThumbnail: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!

    func setup(meal: Meal) {
        self.imageViewThumbnail.sd_setImage(with: URL(string: meal.strMealThumb), placeholderImage: UIImage(), options: [], completed: nil)
        self.labelTitle.text = meal.strMeal
    }

}
