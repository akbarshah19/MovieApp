//
//  MostPopularModel.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/14/23.
//

import Foundation

struct HomeCellModel: Codable {
    var items: [HomeModelList]
}

struct HomeModelList: Codable {
    var id: String
    var image: String?
}
