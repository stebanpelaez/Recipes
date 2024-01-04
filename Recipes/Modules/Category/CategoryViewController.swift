//
//  CategoryViewController.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import UIKit

class CategoryViewController: UICollectionViewController {

    private enum ReuseIdentifiers: String {
        case categoryUICollectionViewCell = "CategoryUICollectionViewCell"
    }

    var viewModel: ICategoryViewModel? = CategoryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewModel()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HomeViewController, let index = sender as? Int {
            destination.viewModel?.category = self.viewModel?.getCategory(at: index)
        }
    }

    private func initViewModel() {
        self.viewModel?.reloadCollectionView = { [weak self] in
            self?.reloadData()
        }

        self.viewModel?.listCategoriesFromService()
    }

    // Refrescar UI CollectionView
    private func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.numberOfCells ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifiers.categoryUICollectionViewCell.rawValue, for: indexPath) as? CategoryUICollectionViewCell, let category = self.viewModel?.getCategory(at: indexPath.row) else {
            return UICollectionViewCell()
        }

        cell.setup(category: category)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "openListMeal", sender: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: 0, height: 0)
        }

        let columns: CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
        let width: CGFloat = floor(adjustedWidth / columns)
        return CGSize(width: width, height: width)
    }

}
