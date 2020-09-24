//
//  DetailProtocols.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 24/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

// MARK:- View Protocols

protocol DetailViewProtocol: class {
    var presenter: DetailPresenterProtocol? { get set }
    
    /// Get detail info about a particular movie
    func detailFromTheMovie(movieData: MovieViewModel)

}

// MARK:- Presenter Protocols

protocol DetailPresenterProtocol: class {
    var view: DetailViewProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    var movie: MovieViewModel? { get set }
}

// MARK:- Router Protocols

protocol DetailRouterProtocol: class {
    /// Create the View and initialize the viper components.
    static func createHomeModule() -> DetailViewProtocol
}
