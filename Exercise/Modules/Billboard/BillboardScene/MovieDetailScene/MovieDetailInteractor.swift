//
//  MovieDetailInteractor.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 08/07/21.
//
//

import UIKit

protocol MovieDetailBusinessLogic {
    func tryRequestMovieDetails(request: MovieDetail.Something.Request)
}

protocol MovieDetailDataStore {
    var moviePosition: Int { get set }
}

class MovieDetailInteractor: MovieDetailBusinessLogic, MovieDetailDataStore {
    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorker?
    var moviePosition = 0
    
    // MARK: Do something
    
    func tryRequestMovieDetails(request: MovieDetail.Something.Request) {
        worker = MovieDetailWorker()
        worker?.doSomeWork()
        
        let response = MovieDetail.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
