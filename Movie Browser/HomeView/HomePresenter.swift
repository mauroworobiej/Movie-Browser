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
}

// MARK:- Interactor Output Protocol

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func pushDataFromInteractor(data: [HomeViewModel]) {
        view?.pushedDataFromPresenter(data: data)
        view?.stopActivityIndicator()
    }
    
    
}
