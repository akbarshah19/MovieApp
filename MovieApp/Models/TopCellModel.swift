//
//  TopCellModel.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/21/23.
//

import Foundation

struct TopCellModel: Codable {
    let items: [TopCellList]
}

struct TopCellList: Codable {
    let id: String
    let rank: String
    let title: String
    let year: String
    let image: String
    let imDbRating: String
}
