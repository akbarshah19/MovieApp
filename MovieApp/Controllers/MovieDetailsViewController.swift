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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(for: id)
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
}
