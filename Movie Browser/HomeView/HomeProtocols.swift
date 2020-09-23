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
    
    func pushedDataFromPresenter(data: [HomeViewModel])
    func startActivityIndicator()
    func stopActivityIndicator()

}

// MARK:- Presenter Protocols

protocol HomePresenterProtocol: class {
    
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func viewDidLoad()
}

// MARK:- Interactor Input Protocols

protocol HomeInteractorInputProtocol: class {
    
    var presenter: HomeInteractorOutputProtocol? { get set }
    var remoteDataManager: HomeRemoteDataManagerInputProtocol? { get set }
    
    /// Start the data request in the External Data Manager
    func fetchData()

}

// MARK:- Interactor Output Protocols

protocol HomeInteractorOutputProtocol: class {
    func pushDataFromInteractor(data: [HomeViewModel])
}

// MARK:- Data Manager Input Protocols

protocol HomeDataManagerInputProtocol: class {
    
}


// MARK:- Router Protocols

protocol HomeRouterProtocol: class {
    
    /// Create the View and initialize the viper components.
    static func createHomeModule() -> UIViewController

}

// MARK:- Remote Data Manager Protocols

protocol HomeRemoteDataManagerInputProtocol: class {
    
    var remoteRequesHandler: HomeRemoteDataManagerOutputProtocol? { get set }
    
    func getDataFromRemoteDataManager()
}


// MARK:- Remote Request Handler Protocols

protocol HomeRemoteDataManagerOutputProtocol: class {
    func serviceResponse(data: Movies)
}

