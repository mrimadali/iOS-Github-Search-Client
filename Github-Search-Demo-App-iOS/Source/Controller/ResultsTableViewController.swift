//
//  ResultsTableViewController.swift
//  Github-Search-Demo-App-iOS
//
//  Created by Mohammad Imad Ali on 22/08/21.
//

import UIKit
import Loaf

class ResultsTableViewController: UITableViewController, UITableViewDataSourcePrefetching {

    // MARK: - Class private variables
    private var repos                      = [Item]()
    private var totalCount                 = 0
    private var selectedIndex              = 0
    private var currentPage                = 1
    private var isFetchingNextPage         = false
    private var cellID                     = "ItemTableViewCell"
    private var loadingID                  = "loading"
    private var kItemHeight:CGFloat        = 100
    private var queryText                  = ""
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        return activity
    }()
    var delegate: SearchDelegate!


    // MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableCell()
        setupActivityIndicatorView()
        registerNotifications()
    }
  
    
    // MARK: - Class private methods
    private func registerTableCell() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        tableView.prefetchDataSource = self
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }

    private func setupActivityIndicatorView() {
        view.addSubview(activityIndicator)
        activityIndicator.stopAnimating()
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            activityIndicator.heightAnchor.constraint(equalToConstant: 20),
            activityIndicator.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(likeRepo), name: NSNotification.Name(Constants.likeNotifications), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dislikeRepo), name: NSNotification.Name(Constants.dislikeNotifications), object: nil)
    }

    private func searchGithubRepo(usingQuery query: String) {
        activityIndicator.startAnimating()
        NetworkAdapter().githubSearchAPI(with: query, pageNo: currentPage, sender: self) { totalResultsCount, jsonArray in
            self.isFetchingNextPage = false
            self.activityIndicator.stopAnimating()
            guard let repoArray = jsonArray else {
                return
            }
            self.totalCount = totalResultsCount
            self.repos += repoArray
            self.tableView.reloadData()
        }
    }
    
    private func fetchNextPage() {
        guard !isFetchingNextPage else { return }
        currentPage += 1
        searchGithubRepo(usingQuery: queryText)
    }

    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.repos.count
    }
    
    @objc func likeRepo() {
        repos[selectedIndex].userPref = .like
        tableView.reloadRows(at: [IndexPath(row: selectedIndex, section: 0)], with: .automatic)
    }
    
    @objc func dislikeRepo() {
        repos[selectedIndex].userPref = .dislike
        tableView.reloadRows(at: [IndexPath(row: selectedIndex, section: 0)], with: .automatic)
    }
    
    private func emptyMessage(message:String) {
        let messageLabel = UILabel(frame: CGRect(x: 10, y: 0, width: view.bounds.size.width-20, height: view.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .label
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.sizeToFit()
        messageLabel.font = UIFont(name: AppFont.regular, size: 13)

        tableView.backgroundView = messageLabel;
        tableView.separatorStyle = .none;
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return totalCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if isLoadingIndexPath(indexPath) {
            return LoadingCell(style: .default, reuseIdentifier: loadingID)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ItemTableViewCell
            let item = repos[row]
            cell.configure(cell: item)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kItemHeight
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.01 * Double(indexPath.row), usingSpringWithDamping: 1, initialSpringVelocity: 4, options: .curveEaseInOut, animations: {
            cell.transform = .identity
            cell.alpha = 1
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let repo = repos[row]
        selectedIndex = row
        delegate.didSelectItem(at: row, item: repo)
    }
    
    // MARK: - Table view prefetch data source
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let needsFetch = indexPaths.contains { $0.row >= self.repos.count }
        if needsFetch {
            fetchNextPage()
        }
    }
}

// MARK: - Search results updating delegates
extension ResultsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text.count >= 3 else {
            emptyMessage(message: Constants.emptySearchMessage)
            return
        }
        tableView.backgroundView = UIView(frame: .zero)
        isFetchingNextPage = false
        totalCount = 0
        currentPage = 1
        queryText = text
        repos.removeAll()
        tableView.reloadData()
        searchGithubRepo(usingQuery: queryText)
    }
}

