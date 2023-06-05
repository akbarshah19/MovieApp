//
//  MovieDetailsTrailerView.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 6/3/23.
//

import UIKit
import youtube_ios_player_helper

class MovieDetailsTrailerView: UIView {
    
    let trailerPlayer: YTPlayerView = {
        let player = YTPlayerView()
        player.layer.masksToBounds = true
        player.layer.cornerRadius = 10
        player.layer.borderColor = UIColor.red.cgColor
        player.layer.borderWidth = 1
        return player
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemBackground
        addSubview(trailerPlayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with videoID: String?) {
        guard let id = videoID else { return }
        trailerPlayer.load(withVideoId: id)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        trailerPlayer.frame = CGRect(x: 10, y: 10, width: width - 20, height: height - 20)
    }
}
