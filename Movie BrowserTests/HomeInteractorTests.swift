//
//  HomeInteractorTests.swift
//  Movie BrowserTests
//
//  Created by Mauro Worobiej on 30/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import XCTest
@testable import Movie_Browser

typealias HomeInteractorProtocol = HomeInteractorInputProtocol & HomeRemoteDataManagerOutputProtocol

class HomeInteractorTests: XCTestCase {
    
    var sut: HomeInteractorProtocol?
    var mockRemoteDataManager: MockRemoteDataManager?
    var mockPresenter: MockPresenter?
    
    override func setUp() {
        sut = HomeInteractor()
        mockRemoteDataManager = MockRemoteDataManager()
        mockPresenter = MockPresenter()
        
        mockRemoteDataManager?.remoteRequesHandler = sut
        sut?.remoteDataManager = mockRemoteDataManager
        sut?.presenter = mockPresenter
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        mockRemoteDataManager = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func testFetchMovies() {
        // Given
        let expectedResult = MovieViewModel(title: "Movie Title",
                                            overview: "Description",
                                            posterPaht: "path/movie")
        let promise = expectation(description: "fetchMove invoked")
        
        // When
        sut?.fetchMovies()
        promise.fulfill()
        wait(for: [promise], timeout: 5)
        
        // Then
        XCTAssertEqual(mockPresenter!.fechedMoviesProperty, expectedResult)
    }
}

class MockRemoteDataManager: HomeRemoteDataManagerInputProtocol {
    
    var remoteRequesHandler: HomeRemoteDataManagerOutputProtocol?
    
    let mockedMovie = Movie(popularity: nil,
                            voteCount: nil,
                            video: nil,
                            posterPath: "path/movie",
                            id: nil,
                            originalTitle: nil,
                            genreIDS: nil,
                            title: "Movie Title",
                            voteAverage: nil,
                            overview: "Description",
                            releaseDate: nil)
    
    lazy var mockedMovies = Movies(page: 1, totalResults: 1, totalPages: 1, results: [mockedMovie])
    
    let mockedBaseUrlImg = BaseImagesUrl(baseUrl: "baseurl/img", posterSizes: ["w300"])
    
    
    
    func getDataFromRemoteDataManager() {
        remoteRequesHandler?.movieServiceResponse(data: mockedMovies)
    }
    
    func getBaseUrlForImages() {
        remoteRequesHandler?.baseUrlServiceResponse(data: mockedBaseUrlImg)
    }
}

class MockPresenter: HomeInteractorOutputProtocol {
    
    var fechedMoviesProperty: MovieViewModel?
    var filteredMoviesProperty: MovieViewModel?
    
    func fechedMovies(data: [MovieViewModel]) {
        fechedMoviesProperty = data[0]
    }
    
    func filteredMovies(data: [MovieViewModel]) {
        filteredMoviesProperty = data[0]
    }
}
