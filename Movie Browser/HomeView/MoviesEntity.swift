//
//  MoviesEntity.swift
//  Movie Browser
//
//  Created by Mauro Worobiej on 23/09/2020.
//  Copyright © 2020 Mauro Worobiej. All rights reserved.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let page: Int?
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Movie
struct Movie: Codable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let originalTitle: String?
    let genreIDS: [Int]?
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}

// MARK:- Images
struct Images: Codable {
    let images: BaseImagesUrl
}

struct BaseImagesUrl: Codable {
    let baseUrl: String
    let posterSizes: [String]
    
    enum CodingKeys: String, CodingKey {
        case baseUrl = "base_url"
        case posterSizes = "poster_sizes"
    }
}
