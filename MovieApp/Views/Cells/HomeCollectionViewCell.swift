//
//  HomeCollectionViewCell.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit
import SDWebImage
import SkeletonView

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    
    public var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.isSkeletonable = true
        return image
    }()
    
    public var imdbRating: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "customYellow")
        label.textAlignment = .center
        label.textColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.adjustsFontSizeToFitWidth = true
        label.isSkeletonable = true
        return label
    }()
    
    public var label: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.isSkeletonable = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isSkeletonable = true
        contentView.backgroundColor = .secondarySystemBackground

        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 15
        contentView.addSubview(imageView)
        contentView.addSubview(imdbRating)
        contentView.addSubview(label)
    }
    
    func configure(with model: HomeModelList) {
        imageView.sd_setImage(with: URL(string: model.image))
        label.text = model.title
        imdbRating.text = model.imDbRating
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imdbRating.text = nil
        label.text = "N/A"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 7, y: 7, width: contentView.width - 14, height: contentView.height - 30 - 17)
        imdbRating.frame = CGRect(x: imageView.right - imageView.width/5 - 5, y: imageView.top + 5, width: imageView.width/5, height: imageView.width/5)
        label.frame = CGRect(x: 7, y: imageView.bottom + 5, width: contentView.width - 14, height: 30)
    }
}
