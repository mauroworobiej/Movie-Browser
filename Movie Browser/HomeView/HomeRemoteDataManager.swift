//
//  HomeRemoteDataManager.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 23/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

class HomeRemoteDataManager: HomeRemoteDataManagerInputProtocol {
    
    // MARK:- Properties
    
    var remoteRequesHandler: HomeRemoteDataManagerOutputProtocol?
    private let apiKey = "2e7aef3dbc345c49c3540bfeea28b24f"
    private let baseUrl = "https://api.themoviedb.org/3"
    
    // MARK:- Remote Data Manager Input Protocol
    func getDataFromRemoteDataManager() {
        let url = URL(string: "\(baseUrl)/discover/movie?api_key=\(apiKey)&sort_by=popularity.desc")!
        
        fetchDataFromService(type: Movies.self, url: url) { result in
            switch result {
            case .success(let movies):
                self.remoteRequesHandler?.movieServiceResponse(data: movies)
            case .failure(let error):
                // TODO:- Handle the error
                print(error)
            }
        }

    }
    
    func getBaseUrl() {
        let url = URL(string: "\(baseUrl)/configuration?api_key=\(apiKey)")!
        
        fetchDataFromService(type: Images.self, url: url) { result in
            switch result {
            case .success(let baseImageUrl):
                self.remoteRequesHandler?.baseUrlServiceResponse(data: baseImageUrl.images)
            case .failure(let error):
                // TODO:- Handle the error
                print(error)
            }
        }
    }
    
    // MARK:- Helper Methods
    
    private func fetchDataFromService<T: Codable>(type: T.Type, url : URL, completion : @escaping (Result<T,Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        DispatchQueue.global(qos: .background).async {
            
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
}
