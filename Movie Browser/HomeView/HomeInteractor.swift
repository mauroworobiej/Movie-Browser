//
//  HomeInteractor.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 23/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
    
    // MARK:- Properties
    var presenter: HomeInteractorOutputProtocol?
    var remoteDataManager: HomeRemoteDataManagerInputProtocol?
    private var movies = [MovieViewModel]()
    private var filteredMovies = [MovieViewModel]()
    private var baseImgUrl: BaseImagesUrl?
    private let group = DispatchGroup()

    // MARK:- Interactor Input Protocol
    
    func fetchMovies() {
        group.enter()
        remoteDataManager?.getDataFromRemoteDataManager()
        group.enter()
        remoteDataManager?.getBaseUrlForImages()
    }
    
    func filterMovies(query: String) {
        filteredMovies = movies.filter({ $0.title.contains(query) })
        presenter?.filteredMovies(data: filteredMovies)
    }
}

// MARK:- Remote Data Manager Protocol

extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
    func baseUrlServiceResponse(data: BaseImagesUrl) {
        baseImgUrl = data
        group.leave()
    }
    
    func movieServiceResponse(data: Movies) {
        group.leave()
        group.notify(queue: .main) {
            let baseUrl = self.baseImgUrl!.baseUrl + self.baseImgUrl!.posterSizes[2]
            for movie in data.results {
                let title = movie.title ?? "No description"
                let overview = movie.overview ?? "No description"
                let posterPath = baseUrl + (movie.posterPath ?? "")
                let singleMoview = MovieViewModel(title: title, overview: overview, posterPaht: posterPath)
                self.movies.append(singleMoview)
            }
            self.presenter?.fechedMovies(data: self.movies)
        }
    }
}
