//
//  SearchCellModel.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/15/23.
//

import Foundation

struct SearchCellModel: Codable {
    let results: [SeaarchModelList]
}

struct SeaarchModelList: Codable {
    let id: String
    let image: String
    let title: String
}
