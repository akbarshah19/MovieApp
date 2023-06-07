//
//  MostPopularModel.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/14/23.
//

import Foundation

enum HomeDataType {
    case mostPopularMovies
    case mostPopularTVs
    case comingSoon
    case inTheaters
}

struct HomeCellModel: Codable {
    var items: [HomeModelList]
}

struct HomeModelList: Codable {
    var id: String
    var title: String
    var image: String
    var imDbRating: String
}
