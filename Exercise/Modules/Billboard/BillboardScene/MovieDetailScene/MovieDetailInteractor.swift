//
//  MovieDetailInteractor.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 08/07/21.
//
//

import UIKit

protocol MovieDetailBusinessLogic {
    func tryRequestMovieDetails()
}

protocol MovieDetailDataStore {
    var moviePosition: Int { get set }
}

class MovieDetailInteractor: MovieDetailBusinessLogic, MovieDetailDataStore {
    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorker?
    var moviePosition = 0
    
    // MARK: Do something
    
    func tryRequestMovieDetails() {
        worker = MovieDetailWorker()
        worker?.requestMovieDetails(withMovie: moviePosition) {
            movieDetailsResult, backgroundSynopsisURL, trailerMp4URL  in
            guard let movieDetails = movieDetailsResult else { return}
            guard let backgroundSynopsisURL = backgroundSynopsisURL else { return}
            guard let trailerMp4URL = trailerMp4URL else { return}
            self.presenter?.presentMovieDetails(movieDetails, backgroundSynopsisURL, trailerMp4URL)
        }
    }
}
