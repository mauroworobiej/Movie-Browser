//
//  DetailPresenter.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 24/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

class DetailPresenter: DetailPresenterProtocol {
    
    // MARK:- Properties
    
    var view: DetailViewProtocol?
    var router: DetailRouterProtocol?    
    var movie: MovieViewModel?
    
    // MARK:- Presenter Protocol
    
    func viewDidLoad() {
        guard let movie = self.movie else { return }
        view?.moviewDetailFromPresenter(movieData: movie)
    }
    
    
}
