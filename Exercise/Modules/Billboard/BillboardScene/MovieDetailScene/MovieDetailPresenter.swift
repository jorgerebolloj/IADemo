//
//  MovieDetailPresenter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 08/07/21.
//
//

import UIKit

protocol MovieDetailPresentationLogic {
    func presentSomething(response: MovieDetail.Something.Response)
}

class MovieDetailPresenter: MovieDetailPresentationLogic {
    weak var viewController: MovieDetailDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: MovieDetail.Something.Response) {
        let viewModel = MovieDetail.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
