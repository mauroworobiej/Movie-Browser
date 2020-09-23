//
//  HomeInteractor.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 23/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
    
    var presenter: HomeInteractorOutputProtocol?
    var remoteDataManager: HomeRemoteDataManagerInputProtocol?
    private var movies = [HomeViewModel]()

    func fetchData() {
        remoteDataManager?.getDataFromRemoteDataManager()
    }
}

// MARK:- Remote Data Manager Protocol

extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
    
    func serviceResponse(data: Movies) {
        for movie in data.results {
            let title = movie.title ?? "No description"
            let overview = movie.overview ?? "No description"
            let posterPath = movie.posterPath
            let singleMoview = HomeViewModel(title: title, overview: overview, posterPaht: posterPath)
            movies.append(singleMoview)
        }
        presenter?.pushDataFromInteractor(data: movies)
    }
    
    
    
}
