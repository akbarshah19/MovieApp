//
//  HomeCollectionViewCell.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit
import SDWebImage

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    
    public var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    public var imdbRating: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "customYellow")
        label.text = "9.2"
        label.textAlignment = .center
        label.textColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    public var label: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(imdbRating)
        contentView.addSubview(label)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
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
        imageView.image = UIImage(named: "images")
//        label.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 5, y: 5, width: contentView.width - 10, height: contentView.height - 30 - 15)
        imdbRating.frame = CGRect(x: imageView.right - imageView.width/5 - 5, y: imageView.top + 5, width: imageView.width/5, height: imageView.width/5)
        label.frame = CGRect(x: 5, y: imageView.bottom + 5, width: contentView.width - 10, height: 30)
    }
}
