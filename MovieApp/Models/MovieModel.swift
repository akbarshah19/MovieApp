//
//  MovieModel.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/31/23.
//

import Foundation

struct MovieModel: Codable {
    var id: String
    var title: String?
    var type: String?
    var image: String?
    var releaseDate: String?
    var runtimeStr: String?
    var plot: String?
    var directors: String?
    var writers: String?
    var stars: String?
    var genres: String?
    var companies: String?
    var ratings: Ratings
    var posters: Posters?
    var trailer: Link?
    var similars: [SimilarsList]?
}

struct Ratings: Codable {
    var imDb: String?
    var metacritic: String?
    var rottenTomatoes: String?
}

struct Posters: Codable {
    var backdrops: [Backdrops]?
}

struct Backdrops: Codable {
    var link: String?
}

struct Link: Codable {
    var link: String?
}

struct SimilarsList: Codable {
    var id: String
    var title: String?
    var image: String?
    var imDbRating: String?
}
