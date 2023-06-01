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
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.estimatedRowHeight = 300
        setUpTableHeader()
        
        let logoTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 35))
        logoTitle.text = "MovieApp"
        logoTitle.font = .systemFont(ofSize: 30, weight: .heavy)
        navigationItem.titleView = logoTitle
        //test
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "t.circle"), style: .done, target: self, action: #selector(didTapTest))
    }
    
    @objc private func didTapTest() {
        let vc = MovieDetailsViewController("123")
        navigationController?.pushViewController(vc, animated: true)
    }

    /// Generic API request
    func fetchData() {
        URLSession.shared.request(url: URL(string: ""),
                                  expecting: [HomeCellModel].self) { [weak self] result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    print(result)
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setUpTableHeader() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search movies"
        tableView.tableHeaderView = searchBar
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.delegate = self
        let model = [HomeModelList(id: "123", image:
                         "https://m.media-amazon.com/images/M/MV5BMDgxOTdjMzYtZGQxMS00ZTAzLWI4Y2UtMTQzN2VlYjYyZWRiXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_Ratio0.6716_AL_.jpg"),
                     HomeModelList(id: "123", image: "https://m.media-amazon.com/images/M/MV5BMDgxOTdjMzYtZGQxMS00ZTAzLWI4Y2UtMTQzN2VlYjYyZWRiXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_Ratio0.6716_AL_.jpg"),
                     HomeModelList(id: "123", image: "https://m.media-amazon.com/images/M/MV5BMDgxOTdjMzYtZGQxMS00ZTAzLWI4Y2UtMTQzN2VlYjYyZWRiXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_Ratio0.6716_AL_.jpg"),
                     ]
        
        if indexPath.row == 0 {
            cell.label.text = "Most Popular Movies"
            cell.configure(with: model)
        } else if indexPath.row == 1 {
            cell.label.text = "Most Popular TVs"
            cell.configure(with: model)
        } else if indexPath.row == 2 {
            cell.label.text = "Coming Soon"
            cell.configure(with: model)
        } else if indexPath.row == 3 {
            cell.label.text = "In Theaters"
            cell.configure(with: model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        return cell
    }
}

extension HomeViewController: HomeTableViewCellDelegate {
    func didTapSeeAll() {
        print("See All tapped!")
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let vc = SearchViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
