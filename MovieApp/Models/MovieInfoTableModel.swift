//
//  MovieInfoTableModel.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 6/2/23.
//

import Foundation

struct MovieInfoTableModel {
    let title: String
    let subTitle: [String]
    var isOpened: Bool
    
    init(title: String, subTitle: [String], isOpened: Bool = false) {
        self.title = title
        self.subTitle = subTitle
        self.isOpened = isOpened
    }
}
