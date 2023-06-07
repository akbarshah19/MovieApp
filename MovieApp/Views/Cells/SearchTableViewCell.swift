//
//  SearchTableViewCell.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/15/23.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    
    public var cellPicture: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(cellPicture)
        contentView.addSubview(cellLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: SeaarchModelList) {
        cellLabel.text = model.title
        cellPicture.sd_setImage(with: URL(string: model.image))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellPicture.image = nil
        cellLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellPicture.frame = CGRect(x: 10,
                                   y: 10,
                                   width: contentView.height - 20,
                                   height: contentView.height - 20)
        cellLabel.frame = CGRect(x: cellPicture.right + 10,
                                 y: 10,
                                 width: contentView.width - cellPicture.width - 20,
                                 height: contentView.height - 20)
    }
}
