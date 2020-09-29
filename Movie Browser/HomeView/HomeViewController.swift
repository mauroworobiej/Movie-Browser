//
//  HomeViewController.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 23/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    // MARK:- Properties
    
    var presenter: HomePresenterProtocol?
    private var movies = [MovieViewModel]()
    private var filteredMovies: [MovieViewModel]?
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(HomeMovieCell.self, forCellReuseIdentifier: "moviewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.delegate = self
        controller.searchBar.delegate = self
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.definesPresentationContext = true
        controller.searchBar.placeholder = "Search for a movie"
        navigationItem.searchController = controller
        return controller
    }()
    
    // MARK:- Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        setupLayout()
        presenter?.viewDidLoad()
    }
    
    // MARK:- Helper Methods
    
    func setupLayout() {
        view.addSubviews(tableView, activityIndicator)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 150),
            activityIndicator.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
}

// MARK:- Home View Protocol

extension HomeViewController: HomeViewProtocol {
    
    func fechedMoviesFromPresenter(data: [MovieViewModel]) {
        movies = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func filteredMoviesFromPresenter(data: [MovieViewModel]) {
        self.filteredMovies = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK:- Table view Data Source

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let moviesToShow: [MovieViewModel]
        if searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true) {
            moviesToShow = filteredMovies!
        } else {
            moviesToShow = movies
        }
        return moviesToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviewCell", for: indexPath) as! HomeMovieCell
        let moviesToShow: [MovieViewModel]
        if searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true) {
            moviesToShow = filteredMovies!
        } else {
            moviesToShow = movies
        }
        let imageURL = moviesToShow[indexPath.row].posterPaht ?? ""
        cell.movieImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: "camera"))
        cell.titleLabel.text = moviesToShow[indexPath.row].title
        cell.descriptionLabel.text = moviesToShow[indexPath.row].overview
        return cell
    }
}

// MARK:- Table view Delegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let moviesToShow: [MovieViewModel]
        if searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true) {
            moviesToShow = filteredMovies!
        } else {
            moviesToShow = movies
        }
        presenter?.presentDetailView(with: moviesToShow[indexPath.row])
    }
}

// MARK: Search Controller Delegate

extension HomeViewController: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: Search bar Delegate

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.filterBy(query: searchText)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
