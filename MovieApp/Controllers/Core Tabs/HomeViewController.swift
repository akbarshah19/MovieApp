//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit
import SkeletonView

class HomeViewController: UIViewController {
    let const = Constants()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        table.isSkeletonable = true
        return table
    }()
    
    private var mostPopularMovies = [HomeModelList]()
    private var mostPopularTVs = [HomeModelList]()
    private var comingSoon = [HomeModelList]()
    private var inTheaters = [HomeModelList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = 300
        tableView.estimatedRowHeight = 300
        setUpTableHeader()
        setUpLogo()
 //       fetchAllData()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "t.circle"), style: .done, target: self, action: #selector(didTapTest))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if mostPopularMovies.isEmpty && mostPopularTVs.isEmpty && comingSoon.isEmpty && inTheaters.isEmpty {
            tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .skeletonDefault),
                                                   animation: nil,
                                                   transition: .crossDissolve(0.25))
        }
    }
    
    @objc private func didTapTest() {
        let vc = MovieDetailsViewController("123")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUpLogo() {
        let logoTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 35))
        logoTitle.text = "MovieApp"
        logoTitle.font = .systemFont(ofSize: 30, weight: .heavy)
        navigationItem.titleView = logoTitle
    }
    
    private func fetchAllData() {
        fetchData(type: .mostPopularMovies)
//        fetchData(type: .mostPopularTVs)
//        fetchData(type: .comingSoon)
//        fetchData(type: .inTheaters)
    }

    /// Generic API request
    func fetchData(type: HomeDataType) {
        var urlString = ""
        
        switch type {
        case .mostPopularMovies:
            urlString = const.mostPopularUrl
        case .mostPopularTVs:
            urlString = const.mostPopularTVsUrl
        case .comingSoon:
            urlString = const.comingSoonUrl
        case .inTheaters:
            urlString = const.inTheatersUrl
        }
        
        URLSession.shared.request(url: URL(string: urlString),
                                  expecting: HomeCellModel.self) { [weak self] result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    switch type {
                    case .mostPopularMovies:
                        self?.mostPopularMovies = result.items
                    case .mostPopularTVs:
                        self?.mostPopularTVs = result.items
                    case .comingSoon:
                        self?.comingSoon = result.items
                    case .inTheaters:
                        self?.inTheaters = result.items
                    }
                    self?.tableView.stopSkeletonAnimation()
                    self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
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

extension HomeViewController: UITableViewDelegate, SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return HomeTableViewCell.identifier
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.delegate = self
        
        if indexPath.row == 0 {
            cell.label.text = "Most Popular Movies"
            cell.configure(with: mostPopularMovies)
        } else if indexPath.row == 1 {
            cell.label.text = "Most Popular TVs"
                cell.configure(with: mostPopularTVs)
        } else if indexPath.row == 2 {
            cell.label.text = "Coming Soon"
                cell.configure(with: comingSoon)
        } else if indexPath.row == 3 {
            cell.label.text = "In Theaters"
                cell.configure(with: inTheaters)
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
    func didTapSeeAll(models: [HomeModelList]) {
        let vc = ListViewController(models: models)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapOnMovie(id: String) {
        let vc = MovieDetailsViewController(id)
        navigationController?.pushViewController(vc, animated: true)
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
