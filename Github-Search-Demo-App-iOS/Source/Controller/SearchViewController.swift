//
//  SearchViewController.swift
//  Github-Search-Demo-App-iOS
//
//  Created by Mohammad Imad Ali on 21/08/21.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Class private variables
    var searchController: UISearchController!
    
    // MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavigationBarAppearence()
        initSearchController()
    }
    
    // MARK: - Class private methods
    private func customNavigationBarAppearence() {
        view.backgroundColor = .white
        navigationItem.title = Constants.githubSearchRepo
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func initSearchController() {
        let resultsVC = ResultsTableViewController(style: .plain)
        resultsVC.delegate = self
        searchController = UISearchController(searchResultsController: resultsVC)
        searchController.searchBar.placeholder = Constants.searchGithubRepo
        searchController.searchResultsUpdater = resultsVC
        navigationItem.searchController = searchController
    }
}

// MARK: - Search delegate methods
extension SearchViewController: SearchDelegate {
    func didSelectItem(at row: Int, item: Item) {
        searchController.searchBar.resignFirstResponder()
        let detailVC = DetailViewController()
        detailVC.repoItem = item
        detailVC.index = row
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
