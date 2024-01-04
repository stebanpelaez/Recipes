//
//  CategoryUICollectionViewCell.swift
//  ChallengeMeli
//
//  Created by Brahyam Pineda Cardona on 3/01/24.
//

import UIKit
import SDWebImage

class CategoryUICollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!

    func setup(category: CategoryItem) {
        self.imageView.sd_setImage(with: URL(string: category.strCategoryThumb), placeholderImage: UIImage(), options: [], completed: nil)
        self.labelName.text = category.strCategory
    }

}
