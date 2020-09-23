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
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "moviewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK:- Helper Methods
    func setupLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }

}

// MARK:- Table view Data Source

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviewCell", for: indexPath)
        cell.textLabel?.text = "Testing cell"
        return cell
    }
    
    
}

// MARK:- Table view Delegate

extension HomeViewController: UITableViewDelegate {
    
}
