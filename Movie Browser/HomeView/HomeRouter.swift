//
//  HomeRouter.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 23/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter: HomeRouterProtocol {
     
    static func createHomeModule() -> UIViewController {
        
        let view = HomeViewController()
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol & HomeRemoteDataManagerOutputProtocol = HomeInteractor()
        let remoteDataManager: HomeRemoteDataManagerInputProtocol = HomeRemoteDataManager()
        let router: HomeRouterProtocol = HomeRouter()
        let nav = UINavigationController(rootViewController: view)
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        remoteDataManager.remoteRequesHandler = interactor
        
        return nav
    }
    
    func presentMovieDetailView(from view: HomeViewProtocol, with: MovieViewModel) {
        // TODO: Present the new viper module form view with the data
    }
    
       
}
