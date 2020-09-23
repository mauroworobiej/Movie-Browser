//
//  HomeInteractor.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 23/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
    
    var presenter: HomePresenterProtocol?
    var remoteDataManager: HomeRemoteDataManagerInputProtocol?

}

// MARK:- Remote Data Manager Protocol

extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
    
    
}
