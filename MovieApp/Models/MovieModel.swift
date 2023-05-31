//
//  MovieModel.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/31/23.
//

import Foundation

struct MovieModel: Codable {
    var type: String?
    var releaseDate: String?
    var runtimeStr: String?
    var plot: String?
    var directors: String?
    var writers: String?
    var stars: String?
    var genres: String?
    var companies: String?
    var imDbRating: String?
    var metacriticRating: String?
    var rottenTomatoes: String?
    var posters: Posters?
    var trailer: Link?
    var similars: [SimilarsList]
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
