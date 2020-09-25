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
        interactor?.fetchData()
    }
    
    func presentDetailView(with viewModel: MovieViewModel) {
        if let view = self.view {
            router?.presentMovieDetailView(from: view, with: viewModel)
        }        
    }
}

// MARK:- Interactor Output Protocol

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func pushDataFromInteractor(data: [MovieViewModel]) {
        view?.pushedDataFromPresenter(data: data)
        view?.stopActivityIndicator()
    }
    
    
}
