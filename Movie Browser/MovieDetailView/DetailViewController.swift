//
//  DetailViewController.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 24/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK:- Properties
    
    var presenter: DetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

// MARK:- Detail View Protocol

extension DetailViewController: DetailViewProtocol {
    
    func detailFromTheMovie(movieData: MovieViewModel) {
        // TODO: complete the view with de movieData
    }
    
    
}
