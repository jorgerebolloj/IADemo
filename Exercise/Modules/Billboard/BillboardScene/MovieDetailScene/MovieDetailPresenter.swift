//
//  MovieDetailPresenter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 08/07/21.
//
//

import UIKit

protocol MovieDetailPresentationLogic {
    func presentMovieDetails(_ movieDetails: MovieRLM, _ backgroundSynopsisURL: String, _ trailerMp4URL: String)
}

class MovieDetailPresenter: MovieDetailPresentationLogic {
    weak var viewController: MovieDetailDisplayLogic?
    
    // MARK: Do something
    
    func presentMovieDetails(_ movieDetails: MovieRLM, _ backgroundSynopsisURL: String, _ trailerMp4URL: String) {
        var movieVideo = ""
        var moviePoster = ""
        let movieMedias = movieDetails.media
        for movieMedia in movieMedias {
            let movieMediaCode = movieMedia.code
            if movieMediaCode == "trailer_mp4" {
                movieVideo = movieMedia.resource == "" ? "withoutVideo" : trailerMp4URL + movieMedia.resource
            }
            if movieMediaCode == "background_synopsis" {
                moviePoster = backgroundSynopsisURL + movieMedia.resource
            }
        }
        let movieName = movieDetails.name
        let movieRating = movieDetails.rating
        let movieGenre = movieDetails.genre
        let movieLength = movieDetails.length
        let movieSynopsis = movieDetails.synopsis
        let viewModel = MovieDetail.Info.ViewModel(movieVideo: movieVideo, movieName: movieName, movieRating: movieRating, movieGenre: movieGenre, movieLength: movieLength, movieSynopsis: movieSynopsis, moviePoster: moviePoster)
        DispatchQueue.main.async {
            self.viewController?.displayMovieDetails(viewModel: viewModel)
        }
    }
}
