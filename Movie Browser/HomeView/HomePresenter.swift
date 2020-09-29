//
//  HomePresenter.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 23/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

class HomePresenter {
    
    // MARK:- Properties
    
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
}

// MARK:- Presenter Protocol

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        view?.startActivityIndicator()
        interactor?.fetchMovies()
    }
    
    func presentDetailView(with viewModel: MovieViewModel) {
        if let view = self.view {
            router?.presentMovieDetailView(from: view, with: viewModel)
        }        
    }
    
    func filterBy(query: String) {
        interactor?.filterMovies(query: query)
       }
}

// MARK:- Interactor Output Protocol

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func fechedMovies(data: [MovieViewModel]) {
        view?.fechedMoviesFromPresenter(data: data)
        view?.stopActivityIndicator()
    }
    
    func filteredMovies(data: [MovieViewModel]) {
        view?.filteredMoviesFromPresenter(data: data)
    }
}
