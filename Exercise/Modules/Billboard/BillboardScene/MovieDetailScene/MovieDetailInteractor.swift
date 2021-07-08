//
//  MovieDetailInteractor.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 08/07/21.
//
//

import UIKit

protocol MovieDetailBusinessLogic {
    func doSomething(request: MovieDetail.Something.Request)
}

protocol MovieDetailDataStore {
    //var name: String { get set }
}

class MovieDetailInteractor: MovieDetailBusinessLogic, MovieDetailDataStore {
    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: MovieDetail.Something.Request) {
        worker = MovieDetailWorker()
        worker?.doSomeWork()
        
        let response = MovieDetail.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
