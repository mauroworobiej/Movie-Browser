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
    var mockPresenter: MockPresenter!
    
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
        let expectedResult: [MovieViewModel]? = [MovieViewModel(title: "Movie Title",
                                            overview: "Description",
                                            posterPaht: "baseurl/imgw300path/movie")]
        
        // When
        sut?.fetchMovies()
        
        // Then
        XCTAssertEqual(mockPresenter!.fechedMoviesProperty, expectedResult)
    }
    
    func testfilterMoviesWhenMovieExist() {
        // Given
        sut?.fetchMovies()
        let expectedResult: [MovieViewModel]? = [MovieViewModel(title: "Movie Title",
                                            overview: "Description",
                                            posterPaht: "baseurl/imgw300path/movie")]
        
        // When
        sut?.filterMovies(query: "Movie")
        
        // Then
        XCTAssertEqual(mockPresenter!.filteredMoviesProperty, expectedResult)
    }
    
    func testfilterMoviesWhenMovieDoesntExist() {
        // Given
        sut?.fetchMovies()
        
        // When
        sut?.filterMovies(query: "Movie Title Doesn't Exist")
        
        // Then
        XCTAssertEqual(mockPresenter!.filteredMoviesProperty, [], "When filter by a non - existing title, the returned array should be empty")
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
    
    var fechedMoviesProperty = [MovieViewModel]()
    var filteredMoviesProperty = [MovieViewModel]()
    
    func fechedMovies(data: [MovieViewModel]) {
        fechedMoviesProperty = data
    }
    
    func filteredMovies(data: [MovieViewModel]) {
        filteredMoviesProperty = data
    }
}
