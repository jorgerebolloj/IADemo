//
//  BillboardPresenter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit
import RealmSwift

protocol BillboardPresentationLogic {
    func presentBillboardSuccess(moviesModel: Results<Object>?)
    func presentBillboardError(message: String?)
    func requestMovieDetail()
}

class BillboardPresenter: BillboardPresentationLogic {
    weak var viewController: BillboardDisplayLogic?
    
    // MARK: Presenter paths
    
    func presentBillboardSuccess(moviesModel: Results<Object>?) {
        guard let movies = moviesModel?.toArray(ofType: MovieRLM.self) else { return }
        var moviesModelDecorated = [Billboard.Info.ViewModel]()
        guard let posterURL = UserDefaults.standard.string(forKey: "posterURL") else { return }
        for movie in movies {
            let movieName = movie.name
            var moviePoster = ""
            let movieMedias = movie.media
            for movieMedia in movieMedias {
                let movieMediaCode = movieMedia.code
                if movieMediaCode == "poster" {
                    moviePoster = posterURL + movieMedia.resource
                }
            }
            let moviePosition = movie.position
            let movieModel = Billboard.Info.ViewModel(name: movieName, poster: moviePoster, position: moviePosition)
            moviesModelDecorated.append(movieModel)
        }
        DispatchQueue.main.async {
            self.viewController?.displayBillboardSuccess(with: moviesModelDecorated)
        }
    }
    
    func presentBillboardError(message: String?) {
        DispatchQueue.main.async {
            let viewModel = AlertViewController.ErrorViewModel(errorTitle: "errorAlertTitle".localized, errorMessage: message ?? "null")
            self.viewController?.displayBillboardError(viewModel: viewModel)
        }
    }
    
     func requestMovieDetail() {
        viewController?.requestMovieDetail()
    }
}
