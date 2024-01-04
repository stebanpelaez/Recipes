//
//  HomeViewController.swift
//  Recipes
//
//  Created by Juan Esteban Pelaez on 3/01/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelEmpty: UILabel!

    let searchController = UISearchController(searchResultsController: nil)

    private enum ReuseIdentifiers: String {
        case mealUITableViewCell = "MealUITableViewCell"
    }

    var viewModel: IHomeViewModel? = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Se inicializan los componentes UI y los handlers del viewModel
        self.configureTitleNavigationBar()
        self.configureSearchBar()
        self.configureTableView()
        self.initViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController, let indexPath = self.tableView.indexPathForSelectedRow {
            destination.viewModel?.meal = self.viewModel?.getMeal(at: indexPath.row)
        }
    }

}
// MARK: - Private Methods
extension HomeViewController {

    private func configureTitleNavigationBar() {
        self.title = self.viewModel?.category?.strCategory
    }

    // Configuracion de la tableView
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsMultipleSelection = false
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 148

        self.tableView.register(UINib(nibName: ReuseIdentifiers.mealUITableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: ReuseIdentifiers.mealUITableViewCell.rawValue)
    }

    private func initViewModel() {
        self.viewModel?.reloadTableView = { [weak self] in
            self?.reloadData()
        }

        self.viewModel?.showNoResultsFound = { [weak self] in
            self?.setVisibilityNoResultsFound(hidden: false)
        }

        self.viewModel?.listMealsFromCategory()
    }

    // Refrescar UI TableView
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // Mostrar u ocultar, label sin resultados
    private func setVisibilityNoResultsFound(hidden: Bool) {
        DispatchQueue.main.async {
            self.labelEmpty.isHidden = hidden
        }
    }

}

// MARK: - UITableView
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfCells ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.mealUITableViewCell.rawValue, for: indexPath) as? MealUITableViewCell, let meal = self.viewModel?.getMeal(at: indexPath.row) else {
            return UITableViewCell()
        }

        cell.setup(meal: meal)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "openDetailMeal", sender: self)
    }

}
// MARK: - UISearchBar Delegates
extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {

    // Se usa para filtrar los elementos de la vista por nombre de la receta
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased() {
            self.viewModel?.filterMeal(searchText: searchText)
        }
    }

    // Cuando se cancela la busqueda se vuelven a mostrar todos los elementos
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.resetFilter()
        self.reloadData()
    }

}
// MARK: - UISearchBar UI
extension HomeViewController {

    // Configuracion UI, se agrega un searchController para el buscador
    private func configureSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.autocapitalizationType = .none
        self.searchController.searchBar.showsScopeBar = true
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = "Buscar"
        self.searchController.searchBar.setNewcolor(color: UIColor.white)

        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController?.searchBar.delegate = self

        self.extendedLayoutIncludesOpaqueBars = true
        self.definesPresentationContext = true
    }

}
