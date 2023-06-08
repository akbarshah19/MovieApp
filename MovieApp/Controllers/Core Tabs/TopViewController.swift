//
//  TopViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit

class TopPageViewController: UIViewController {
    let const = Constants()
    private var segmentedControl = UISegmentedControl()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(TopTableViewCell.self, forCellReuseIdentifier: TopTableViewCell.identifier)
        table.isHidden = true
        return table
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.color = .lightGray
        spinner.hidesWhenStopped = true
        return spinner
    }()

    private var model = [TopCellList]() {
        didSet {
            if !model.isEmpty {
                tableView.isHidden = false
                spinner.stopAnimating()
            }
        }
    }
    private var topMovies = [TopCellList]()
    private var topTVs = [TopCellList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(spinner)
        tableView.delegate = self
        tableView.dataSource = self
                
        setUpSegmentedControl()
        fetchDataForMovies()
        fetchDataForTVs()
    }
    
    private func setUpSegmentedControl() {
        let items = ["Top Movies", "Top TVs"]
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRect(x: 80, y: view.safeAreaInsets.top + 10, width: view.width - 160, height: 35)
        segmentedControl.selectedSegmentIndex = 0
        didTapSegmentControl()
        navigationItem.titleView = segmentedControl
        segmentedControl.addTarget(self, action: #selector(didTapSegmentControl), for: .valueChanged)
    }
    
    @objc private func didTapSegmentControl() {
        if segmentedControl.selectedSegmentIndex == 0 {
            model = topMovies
            tableView.reloadData()
        } else {
            model = topTVs
            tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = view.bounds
    }
    
    /// Generic API request
    private func fetchDataForMovies() {
        URLSession.shared.request(url: URL(string: const.topMoviesUrl),
                                  expecting: TopCellModel.self) { [weak self] result in
            switch result {
            case .success(let result):
                var model = [TopCellList]()
                DispatchQueue.main.async {
                    for i in 0...30 {
                        let items = result.items
                        let sampleModel = TopCellList(id: items[i].id,
                                                      rank: items[i].rank,
                                                      title: items[i].title,
                                                      year: items[i].year,
                                                      image: items[i].image,
                                                      imDbRating: items[i].imDbRating)
                        model.append(sampleModel)
                    }
                    self?.model = model
                    self?.topMovies = model
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Generic API request
    private func fetchDataForTVs() {
        URLSession.shared.request(url: URL(string: const.topTVsUrl),
                                  expecting: TopCellModel.self) { [weak self] result in
            switch result {
            case .success(let result):
                var model = [TopCellList]()
                DispatchQueue.main.async {
                    for i in 0...30 {
                        let items = result.items
                        let sampleModel = TopCellList(id: items[i].id,
                                                      rank: items[i].rank,
                                                      title: items[i].title,
                                                      year: items[i].year,
                                                      image: items[i].image,
                                                      imDbRating: items[i].imDbRating)
                        model.append(sampleModel)
                    }
                    self?.topTVs = model
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TopPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopTableViewCell.identifier, for: indexPath) as! TopTableViewCell
        cell.configure(with: model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
