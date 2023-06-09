//
//  Constants.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/14/23.
//

import Foundation

let key = "k_ljm3817b" //ciphertheworld@gmail.com
//let key = "k_a4y18vpg" ////cyphertheworld2@gmail.com

struct Constants {
    
    let mostPopularUrl = "https://imdb-api.com/en/API/MostPopularMovies/\(key)"
    let mostPopularTVsUrl = "https://imdb-api.com/en/API/MostPopularTVs/\(key)"
    let comingSoonUrl = "https://imdb-api.com/en/API/ComingSoon/\(key)"
    let inTheatersUrl = "https://imdb-api.com/en/API/InTheaters/\(key)"
    
    let topMoviesUrl = "https://imdb-api.com/en/API/Top250Movies/\(key)"
    let topTVsUrl = "https://imdb-api.com/en/API/Top250TVs/\(key)"
    
    func movieDetailsUrl(id: String) -> String {
        return "https://imdb-api.com/en/API/Title/\(key)/\(id)/FullActor,Posters,Images,Trailer,Ratings,"
    }
    
    func searchMovieUrl(for text: String) -> String {
        return "https://imdb-api.com/en/API/Search/\(key)/\(text)"
    }
    
    func movieTrailerUrl(id: String) -> String {
        return "https://imdb-api.com/en/API/YouTubeTrailer/\(key)/\(id)"
    }
    
    func commentsUrl(id: String) -> String {
        return "https://imdb-api.com/en/API/Reviews/\(key)/\(id)"
    }
}
