//
//  DetailViewController.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 24/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    // MARK:- Properties
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.register(DetailMovieCell.self, forCellReuseIdentifier: "detailMoviewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var presenter: DetailPresenterProtocol?
    private var movie: MovieViewModel?
    
    // MARK:- Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        presenter?.viewDidLoad()
        setupLayout()
    }
    
    // MARK: - Helper Methods
    
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

// MARK:- Detail View Protocol

extension DetailViewController: DetailViewProtocol {
    
    func moviewDetailFromPresenter(movieData: MovieViewModel) {
        movie = movieData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK:- Table view Data Source

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailMoviewCell", for: indexPath) as! DetailMovieCell
        let imageURL = movie?.posterPaht ?? ""
        cell.movieImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: "camera"))
        cell.titleLabel.text = movie?.title
        cell.descriptionLabel.text = movie?.overview
        return cell
    }
}
