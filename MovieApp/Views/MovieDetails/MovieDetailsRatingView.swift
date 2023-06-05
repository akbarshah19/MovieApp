//
//  MovieDetailsRatingView.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 6/2/23.
//

import UIKit

class MovieDetailsRatingView: UIView {
    
    let imdbLabel: UILabel = {
        let label = UILabel()
        label.text = "IMDB:"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    
    let imdbProgress: UIProgressView = {
        let view = UIProgressView()
        view.progress = 1.0
        view.tintColor = .secondaryLabel
        return view
    }()
    
    let imdbRating: UILabel = {
        let label = UILabel()
        label.text = "-/10"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .right
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .thin)
        return label
    }()
//MARK: -
    let metaCriticLabel: UILabel = {
        let label = UILabel()
        label.text = "Metacritic:"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    
    let metaCriticProgress: UIProgressView = {
        let view = UIProgressView()
        view.progress = 1.0
        view.tintColor = .secondaryLabel
        return view
    }()
    
    let metaCriticRating: UILabel = {
        let label = UILabel()
        label.text = "-/10"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .right
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .thin)
        return label
    }()
//MARK: -
    let rottenTomatoesLabel: UILabel = {
        let label = UILabel()
        label.text = "Rotten Tomatoes:"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    
    let rottenTomatoesProgress: UIProgressView = {
        let view = UIProgressView()
        view.progress = 1.0
        view.tintColor = .secondaryLabel
        return view
    }()
    
    let rottenTomatoesRating: UILabel = {
        let label = UILabel()
        label.text = "-/10"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .right
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .thin)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemBackground
        
        addSubview(imdbLabel)
        addSubview(imdbProgress)
        addSubview(imdbRating)
        addSubview(metaCriticLabel)
        addSubview(metaCriticProgress)
        addSubview(metaCriticRating)
        addSubview(rottenTomatoesLabel)
        addSubview(rottenTomatoesProgress)
        addSubview(rottenTomatoesRating)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Ratings) {
        if let rating = model.imDb {
            let a = (rating as NSString).floatValue
            imdbRating.text = "\(rating)/10"
            imdbProgress.progress = a/10
            imdbProgress.tintColor = .orange
        } else {
            imdbRating.text = "-/10"
        }
        
        if let rating = model.metacritic {
            let a = (rating as NSString).floatValue
            metaCriticRating.text = "\(a/10)/10"
            metaCriticProgress.progress = Float(a)/100
            metaCriticProgress.tintColor = .orange
        } else {
            metaCriticRating.text = "-/10"
        }
        
        if let rating = model.rottenTomatoes {
            let a = (rating as NSString).floatValue
            rottenTomatoesRating.text = "\(a/10)/10"
            rottenTomatoesProgress.progress = Float(a)/100
            rottenTomatoesProgress.tintColor = .orange
        } else {
            rottenTomatoesRating.text = "-/10"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imdbLabel.frame = CGRect(x: 10, y: 10, width: width/2 - 40, height: 24)
        imdbRating.frame = CGRect(x: width - 55, y: 10, width: 45, height: 24)
        imdbProgress.frame = CGRect(x: Int(imdbLabel.right), y: 21, width: Int(width - imdbLabel.width - imdbRating.width - 20), height: 24)
        
        metaCriticLabel.frame = CGRect(x: 10, y: imdbLabel.bottom, width: width/2 - 40, height: 24)
        metaCriticRating.frame = CGRect(x: width - 55, y: imdbLabel.bottom, width: 45, height: 24)
        metaCriticProgress.frame = CGRect(x: Int(imdbLabel.right), y: Int(imdbLabel.bottom) + 11, width: Int(width - imdbLabel.width - imdbRating.width - 20), height: 24)
        
        rottenTomatoesLabel.frame = CGRect(x: 10, y: metaCriticLabel.bottom, width: width/2 - 40, height: 24)
        rottenTomatoesRating.frame = CGRect(x: width - 55, y: metaCriticLabel.bottom, width: 45, height: 24)
        rottenTomatoesProgress.frame = CGRect(x: Int(imdbLabel.right), y: Int(metaCriticLabel.bottom) + 11, width: Int(width - imdbLabel.width - imdbRating.width - 20), height: 24)
    }

}
