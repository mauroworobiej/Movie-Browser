//
//  HomeRemoteDataManager.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 23/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

class HomeRemoteDataManager: HomeRemoteDataManagerInputProtocol {
    
    var remoteRequesHandler: HomeRemoteDataManagerOutputProtocol?
    private let apiKey = "2e7aef3dbc345c49c3540bfeea28b24f"
    
    func getDataFromRemoteDataManager() {
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&sort_by=release_date.desc")!
        
        fetchDataFromService(type: Movies.self, url: url) { result in
            switch result {
            case .success(let movies):
                self.remoteRequesHandler?.serviceResponse(data: movies)
            case .failure(let error):
                // TODO:- Handle the error
                print(error)
            }
            
        }
    }
    
    private func fetchDataFromService<T: Codable>(type: T.Type, url : URL, completion : @escaping (Result<T,Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // TODO:- make an Errors Enum
            if let error = error {
                completion(.failure(error))
                return
            }
            // Success
            guard let data = data else { return }
            do {
                let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(jsonResponse))
            } catch let parsingError {
                // TODO:- Use the error enum
                completion(.failure(parsingError))
            }
        }
        task.resume()
    }
    
    
}
