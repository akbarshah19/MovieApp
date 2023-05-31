//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    let const = Constants()
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
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        setUpSearchBar()
    }
    
    private func setUpSearchBar() {
        searchBar.frame = CGRect(x: 0, y: 0, width: view.width, height: 50)
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
    }
    
    private func fetchData(for text: String) {
        URLSession.shared.request(url: URL(string: const.searchMovieUrl(for: text)),
                                  expecting: SearchCellModel.self) { [weak self] result in
            switch result {
            case .success(let result):
                var model = [SeaarchModelList]()
                for i in result.results {
                    let sampleModel = SeaarchModelList(id: i.id, image: i.image, title: i.title)
                    model.append(sampleModel)
                }
                
                DispatchQueue.main.async {
                    self?.model = model
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
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
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MovieDetailsViewController(model[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        DispatchQueue.main.async {
            if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelButton.isEnabled = true
            }
        }
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        print(text)
        fetchData(for: text)
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }
}
