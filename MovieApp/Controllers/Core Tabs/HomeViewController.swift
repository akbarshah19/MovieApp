//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        return bar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(searchBar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.frame = CGRect(x: 0,
                                 y: Int(view.safeAreaInsets.top),
                                 width: Int(view.width),
                                 height: 50)
        tableView.frame = CGRect(x: 0,
                                 y: Int(searchBar.bottom),
                                 width: Int(view.width),
                                 height: Int(view.height - searchBar.height))
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
