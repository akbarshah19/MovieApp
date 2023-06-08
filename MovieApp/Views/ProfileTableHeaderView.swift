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
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.image = UIImage(named: "person")
        return image
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.text = "Akbar Jumanazarov"
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "ciphertheworld@gmail.com"
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemBackground
        addSubview(image)
        addSubview(usernameLabel)
        addSubview(emailLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        usernameLabel.frame = CGRect(x: 16, y: bottom - 35 - 15 - 15, width: width - 32, height: 35)
        emailLabel.frame = CGRect(x: 16, y: usernameLabel.bottom, width: width - 32, height: 15)
        let imageHeight = height - usernameLabel.height - emailLabel.height - 10 - 10 - 10
        image.frame = CGRect(x: 0, y: 10, width: imageHeight, height: imageHeight)
        image.center.x = center.x
        image.layer.cornerRadius = (imageHeight)/2

    }

}
