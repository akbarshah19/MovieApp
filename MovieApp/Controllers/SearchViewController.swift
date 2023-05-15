//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return table
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    private var model = [SeaarchModelList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        setUpDragButton()
        setUpTableHeader()
    }
    
    private func setUpDragButton() {
        let dragButton = UIButton()
        dragButton.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        dragButton.setImage(UIImage(systemName: "chevron.compact.down",
                                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 45)),
                                    for: .normal)
        dragButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        navigationItem.titleView = dragButton
    }
    
    private func setUpTableHeader() {
        searchBar.frame = CGRect(x: 0, y: 0, width: view.width, height: 50)
        searchBar.placeholder = "Search"
        tableView.tableHeaderView = searchBar
    }
    
    func fetchData() {
        
    }
    
    @objc func didTapDismiss() {
        dismiss(animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.configure(with: model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
