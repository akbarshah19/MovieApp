//
//  HomeTableViewCell.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit
import SkeletonView

protocol HomeTableViewCellDelegate: AnyObject {
    func didTapSeeAll(models: [HomeModelList])
    func didTapOnMovie(id: String)
}

/// Cell with label and collectionView
class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "HomeTableViewCell"
    
    weak var delegate: HomeTableViewCellDelegate?
    
    public let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    public let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        view.register(HomeCollectionViewCell.self,
                      forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        return view
    }()
    
    public let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All>", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isSkeletonable = true
        collectionView.isSkeletonable = true
        
        selectionStyle = .none
        contentView.clipsToBounds = true
        contentView.addSubview(seeAllButton)
        seeAllButton.addTarget(self, action: #selector(didTapSeeAllButton), for: .touchUpInside)
        contentView.addSubview(label)
        contentView.addSubview(collectionView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    var models = [HomeModelList]()
    func configure(with models: [HomeModelList]) {
        self.models = models
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        seeAllButton.frame = CGRect(x: contentView.right - 80, y: 0, width: 80, height: 50)
        label.frame = CGRect(x: 10,
                             y: 0,
                             width: Int(contentView.width - seeAllButton.width - 10) - 20,
                             height: 50)
        collectionView.frame = CGRect(x: 10,
                                      y: Int(label.bottom),
                                      width: Int(contentView.width - 20),
                                      height: Int(contentView.height - label.height))
    }
    
    @objc func didTapSeeAllButton() {
        delegate?.didTapSeeAll(models: models)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        HomeCollectionViewCell.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard !models.isEmpty else {
            print("HomeTVC: Model is empty!")
            return UICollectionViewCell.init(frame: .zero)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier,
                                                      for: indexPath) as! HomeCollectionViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.didTapOnMovie(id: models[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 250)
    }
}
