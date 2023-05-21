//
//  TopTableViewCell.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/21/23.
//

import UIKit

class TopTableViewCell: UITableViewCell {
    static let identifier = "TopTableViewCell"
    
    public var cellPicture: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        image.image = UIImage(systemName: "star")
        return image
    }()
    
    private let cellRank: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.layer.masksToBounds = true
        label.clipsToBounds = true
        label.backgroundColor = .systemYellow
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    private let cellYear: UILabel = {
        let label = UILabel()
        label.text = "Year: 1994"
        return label
    }()
    
    private let cellImDb: UILabel = {
        let label = UILabel()
        label.text = "ImDb: 6.7"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        clipsToBounds = true
        contentView.addSubview(cellPicture)
        contentView.addSubview(cellRank)
        contentView.addSubview(cellLabel)
        contentView.addSubview(cellYear)
        contentView.addSubview(cellImDb)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TopCellList) {
        cellPicture.sd_setImage(with: URL(string: model.image))
        cellRank.text = model.rank
        cellLabel.text = model.title
        cellImDb.text = "ImDb: \(model.imDbRating)"
        cellYear.text = "Year: \(model.year)"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cellPicture.image = nil
        cellRank.text = nil
        cellLabel.text = nil
        cellImDb.text = nil
        cellYear.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellPicture.frame = CGRect(x: 10,
                                   y: 10,
                                   width: contentView.height - 20,
                                   height: contentView.height - 20)
        cellRank.frame = CGRect(x: cellPicture.right - cellPicture.width/4 - 5,
                                y: cellPicture.top + 5,
                                width: cellPicture.width/4,
                                height: cellPicture.width/4)
        cellRank.layer.cornerRadius = (cellPicture.width/4)/2
        
        cellLabel.frame = CGRect(x: cellPicture.right + 10,
                                 y: 10,
                                 width: contentView.width - cellPicture.width - 20,
                                 height: contentView.height - cellYear.height - 20)
        cellYear.frame = CGRect(x: cellPicture.right + 10,
                                y: cellLabel.bottom,
                                width: 100,
                                height: 20)
        cellImDb.frame = CGRect(x: cellYear.right + 10,
                                y: cellLabel.bottom,
                                width: 100,
                                height: 20)
    }
}
