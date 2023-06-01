//
//  MovieDetailsTopView.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 6/1/23.
//

import UIKit

class MovieDetailsTopView: UIView {
    let backgroundImage = UIImageView()
    let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.red.cgColor
        image.layer.borderWidth = 1
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    let movieLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .heavy)
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 1
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .darkGray
        addSubviews()
        
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(backgroundImage)
        addSubview(movieImage)
        addSubview(movieLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImage.frame = CGRect(x: 0, y: 0, width: Int(width), height: Int(width*9/16))
        addGradient()
        
        let movieImageHeight = Int((width/2.5)*4/3)
        movieImage.frame = CGRect(x: 0, y: Int(backgroundImage.bottom - CGFloat(movieImageHeight/2)), width: Int(width/2.5), height: movieImageHeight)
        movieImage.center.x = center.x
        movieLabel.frame = CGRect(x: 0, y: movieImage.bottom + 10, width: width - 20, height: 35)
        movieLabel.center.x = center.x
    }
    
    private func addGradient() {
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "swift")
        let gradient = CAGradientLayer()
        gradient.frame = backgroundImage.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.orange.cgColor]
        backgroundImage.layer.insertSublayer(gradient, at: 0)
    }
}
