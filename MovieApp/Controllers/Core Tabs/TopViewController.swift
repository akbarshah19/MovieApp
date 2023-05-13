//
//  TopViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit

class TopPageViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
    }
}
