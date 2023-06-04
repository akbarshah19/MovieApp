//
//  MovieDetailsSimilarsView.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 6/3/23.
//

import UIKit

protocol MovieDetailsSimilarsViewDelegate: AnyObject {
    func didTapSeeAll(models: [HomeModelList])
}

class MovieDetailsSimilarsView: UIView, UITableViewDelegate, UITableViewDataSource {
    weak var delegate: MovieDetailsSimilarsViewDelegate?
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }
    
    private var models = [HomeModelList]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func configure(with models: [SimilarsList]?) {
        guard let safeModels = models else {
            return
        }
        
        for i in safeModels {
            if let imageUrl = i.image {
                let sampleModel = HomeModelList(id: i.id, image: imageUrl)
                self.models.append(sampleModel)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.label.text = "Similars"
        if models.count > 10 {
            var lessModels = [HomeModelList]()
            for i in 0...9 {
                lessModels.append(models[i])
            }
            cell.configure(with: lessModels)
        } else {
            cell.configure(with: models)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapSeeAll(models: models)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
