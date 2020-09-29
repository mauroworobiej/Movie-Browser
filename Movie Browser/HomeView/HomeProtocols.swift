//
//  HomeProtocols.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 23/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation
import UIKit

// MARK:- View Protocols

protocol HomeViewProtocol: class {
     
    var presenter: HomePresenterProtocol? { get set }
    
    func fechedMoviesFromPresenter(data: [MovieViewModel])
    func filteredMoviesFromPresenter(data: [MovieViewModel])
    func startActivityIndicator()
    func stopActivityIndicator()
}

// MARK:- Presenter Protocols

protocol HomePresenterProtocol: class {
    
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func viewDidLoad()
    func presentDetailView(with viewModel: MovieViewModel)
    func filterBy(query: String)
}

// MARK:- Interactor Input Protocols

protocol HomeInteractorInputProtocol: class {
    
    var presenter: HomeInteractorOutputProtocol? { get set }
    var remoteDataManager: HomeRemoteDataManagerInputProtocol? { get set }
    
    /// Start the data request in the External Data Manager
    func fetchMovies()
    /// Filter the movies titles that match with query pased by paramether
    func filterMovies(query: String)
}

// MARK:- Interactor Output Protocols

protocol HomeInteractorOutputProtocol: class {
    
    /// Used for the Interactor to pass an array of HomeViewModel to the presenter.
    func fechedMovies(data: [MovieViewModel])
    /// Used for the Interactor to pass an array of HomeViewModel, filtered by title, to the presenter.
    func filteredMovies(data: [MovieViewModel])
}

// MARK:- Router Protocols

protocol HomeRouterProtocol: class {
    
    /// Create the View and initialize the viper components.
    static func createHomeModule() -> UIViewController
    /// Push a detail view to a view's navigation controller.
    func presentMovieDetailView(from view: HomeViewProtocol, with data: MovieViewModel)
}

// MARK:- Remote Data Manager Protocols

protocol HomeRemoteDataManagerInputProtocol: class {
    
    var remoteRequesHandler: HomeRemoteDataManagerOutputProtocol? { get set }
    
    /// RemoteDataManager send Movies data from the API to the Interactor
    func getDataFromRemoteDataManager()
    /// RemoteDataManager send the baseUrl(need it to conform the img url) from the API to the Interactor
    func getBaseUrlForImages()
}

// MARK:- Remote Request Handler Protocols

protocol HomeRemoteDataManagerOutputProtocol: class {
    func movieServiceResponse(data: Movies)
    func baseUrlServiceResponse(data: BaseImagesUrl)
}
