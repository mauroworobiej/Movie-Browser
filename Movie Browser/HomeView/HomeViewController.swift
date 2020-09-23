//
//  HomeViewController.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 23/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK:- Properties
    
    var presenter: HomePresenterProtocol?
    private var movies = [HomeViewModel]()

    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "moviewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK:- Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        presenter?.viewDidLoad()
    }
    
    // MARK:- Helper Methods
    
    func setupLayout() {
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 150),
            activityIndicator.heightAnchor.constraint(equalToConstant: 150)


        ])
    }
}

// MARK:- Home View Protocol

extension HomeViewController: HomeViewProtocol {
    
    func pushedDataFromPresenter(data: [HomeViewModel]) {
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
}

// MARK:- Table view Data Source

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviewCell", for: indexPath)
        cell.textLabel?.text = movies[indexPath.row].title
        return cell
    }
}

// MARK:- Table view Delegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO:- Instanciar el 2º modulo de viper. Detail View.
    }
}
