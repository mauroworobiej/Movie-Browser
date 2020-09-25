//
//  DetailRouter.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 24/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation
import UIKit

class DetailRouter: DetailRouterProtocol {
    
    static func createHomeModule(with data: MovieViewModel) -> DetailViewProtocol {
        
        let view = DetailViewController()
        let presenter: DetailPresenterProtocol = DetailPresenter()
        let router: DetailRouterProtocol = DetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.movie = data
        
        return view
    }
}
