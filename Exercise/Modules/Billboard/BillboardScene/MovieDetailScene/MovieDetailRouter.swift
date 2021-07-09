//
//  MovieDetailRouter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 08/07/21.
//
//

import UIKit

@objc protocol MovieDetailRoutingLogic {}

protocol MovieDetailDataPassing {
    var dataStore: MovieDetailDataStore? { get }
}

class MovieDetailRouter: NSObject, MovieDetailRoutingLogic, MovieDetailDataPassing {
    weak var viewController: MovieDetailViewController?
    var dataStore: MovieDetailDataStore?
}
