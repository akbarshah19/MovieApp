//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/31/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    let const = Constants()
    let id: String
    
    init(_ id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private var topView = MovieDetailsTopView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark",
                                                                           withConfiguration: UIImage.SymbolConfiguration(pointSize: 20,
                                                                                                                          weight: .regular)),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
//        fetchData(for: id)
        addSubvies()
    }
    
    private func addSubvies() {
        view.addSubview(scrollView)
        scrollView.addSubview(topView)
    }
    
    @objc private func didTapSave() {
        
    }
    
    private func fetchData(for id: String) {
        URLSession.shared.request(url: URL(string: const.movieDetailsUrl(id: id)),
                                  expecting: MovieModel.self) { [weak self] result in
            switch result {
            case .success(let result):
                print(result)
                DispatchQueue.main.async {
//                    self?.model = model
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.width, height: 1750)
        topView.frame = CGRect(x: 0, y: -100, width: view.width, height: 800)
    }
}
