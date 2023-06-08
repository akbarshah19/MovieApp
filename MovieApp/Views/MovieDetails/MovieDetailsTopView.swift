//
//  MovieDetailsTopView.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 6/1/23.
//

import UIKit
import ShimmerSwift

protocol MovieDetailsTopViewDelegate: AnyObject {
    func didTapWatchNow(link: String?)
}

class MovieDetailsTopView: UIView {
    weak var delegate: MovieDetailsTopViewDelegate?
    
    let backgroundImage = UIImageView()
    
    let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .secondaryLabel
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()
    
    let movieLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .heavy)
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let releaseLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let runtimeLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let watchButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .secondaryLabel
        button.setTitle("Watch Now", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        return button
    }()
    
    let shimmerButton: ShimmeringView = {
        let shimmer = ShimmeringView()
        shimmer.shimmerSpeed = 100
        shimmer.shimmerLayer?.masksToBounds = true
        shimmer.shimmerLayer?.cornerRadius = 10
        shimmer.backgroundColor = .white
        shimmer.isShimmering = false
        shimmer.shimmerSpeed = 20
        shimmer.shimmerPauseDuration = 1
        return shimmer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemBackground
        addSubviews()
        shimmerButton.contentView = watchButton
        watchButton.addTarget(self, action: #selector(watchButtonPressed), for: .touchUpInside)
    }
    
    private var watchLink: String? = nil
    func configure(with model: MovieModel) {
        if let bgImageUrl = model.posters?.backdrops?.first?.link {
            backgroundImage.sd_setImage(with: URL(string: bgImageUrl))
        } else {
            backgroundImage.image = UIImage(named: "swift")
        }
        
        if let imageUrlString = model.image  {
            movieImage.sd_setImage(with: URL(string: imageUrlString))
        } else {
            movieImage.image = UIImage(named: "images")
        }
        
        if let title = model.title {
            movieLabel.text = title
        } else {
            movieLabel.text = "-"
        }
        
        if let genres = model.genres {
            genreLabel.text = genres
        } else {
            genreLabel.text = "-"
        }
        
        if let runtime = model.runtimeStr {
            runtimeLabel.text = runtime
        } else {
            runtimeLabel.text = "-"
        }
        
        if let date = model.releaseDate {
            releaseLabel.text = date
        } else {
            releaseLabel.text = "-"
        }
        
        if let link = model.trailer?.link {
            watchLink = link
            watchButton.backgroundColor = .red
            shimmerButton.isShimmering = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func watchButtonPressed() {
        delegate?.didTapWatchNow(link: watchLink)
    }
    
    func addSubviews() {
        addSubview(backgroundImage)
        addSubview(movieImage)
        addSubview(movieLabel)
        addSubview(genreLabel)
        addSubview(releaseLabel)
        addSubview(runtimeLabel)
        addSubview(shimmerButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImage.frame = CGRect(x: 0, y: 0, width: Int(width), height: Int(width*9/16))
        addGradient()
        
        let movieImageHeight = Int((width/2.5)*4/3)
        movieImage.frame = CGRect(x: 0, y: Int(backgroundImage.bottom - CGFloat(movieImageHeight/2)), width: Int(width/2.5), height: movieImageHeight)
        movieImage.center.x = center.x
        movieLabel.frame = CGRect(x: 20, y: movieImage.bottom + 5, width: width - 40, height: 35)
        genreLabel.frame = CGRect(x: 20, y: movieLabel.bottom, width: width - 40, height: 20)
        runtimeLabel.frame = CGRect(x: 20, y: genreLabel.bottom, width: width/2 - 10, height: 20)
        releaseLabel.frame = CGRect(x: width/2 + 10, y: genreLabel.bottom, width: width/2 - 30, height: 20)
        shimmerButton.frame = CGRect(x: 20, y: releaseLabel.bottom + 10, width: width - 40, height: 50)
    }
    
    private func addGradient() {
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "swift")
        let gradient = CAGradientLayer()
        gradient.frame = backgroundImage.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        backgroundImage.layer.insertSublayer(gradient, at: 0)
    }
}
