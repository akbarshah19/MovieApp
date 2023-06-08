//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit
import Lottie

class SearchViewController: UIViewController {
    
    let const = Constants()
    let searchBar = UISearchBar()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        table.isHidden = true
        return table
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.isHidden = true
        spinner.style = .medium
        spinner.color = .lightGray
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    let animationView: LottieAnimationView = {
        let view = LottieAnimationView(name: "searchingAnimation")
        view.contentMode = .scaleAspectFill
        view.loopMode = .loop
        view.play()
        return view
    }()
    
    private var model = [SeaarchModelList]() {
        didSet {
            if !model.isEmpty {
                spinner.stopAnimating()
                tableView.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupAnimation()
        searchBar.becomeFirstResponder()
        view.addSubview(animationView)
        view.addSubview(tableView)
        view.addSubview(spinner)
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animationView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 50, width: view.width/2, height: view.width/2)
        animationView.center.x = view.center.x
        tableView.frame = view.bounds
        spinner.center = view.center
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
    
    private func setupAnimation() {
        
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
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
        searchBar.endEditing(true)
        spinner.isHidden = false
        animationView.isHidden = true
        spinner.startAnimating()
        fetchData(for: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }
}
