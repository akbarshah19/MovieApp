//
//  ProfileTableHeaderView.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 6/7/23.
//

import UIKit

class ProfileTableHeaderView: UIView {
    
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .red
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        return image
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .secondarySystemBackground
        addSubview(image)
        addSubview(usernameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.frame = CGRect(x: 10, y: 10, width: height - 20, height: height - 20)
        image.layer.cornerRadius = (height - 20)/2
        usernameLabel.frame = CGRect(x: image.right + 10, y: 0, width: width - image.width - 30, height: 50)
        usernameLabel.center.y = center.y
    }

}
