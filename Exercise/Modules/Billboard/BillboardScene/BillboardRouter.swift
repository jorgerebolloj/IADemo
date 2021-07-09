//
//  BillboardRouter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

@objc protocol BillboardRoutingLogic {
    func tryToRequestMovieDetail()
}

protocol BillboardDataPassing {
  var dataStore: BillboardDataStore? { get }
}

class BillboardRouter: NSObject, BillboardRoutingLogic, BillboardDataPassing {
  weak var viewController: BillboardViewController?
  var dataStore: BillboardDataStore?
  
  // MARK: Routing
    func tryToRequestMovieDetail() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        navigateToMovieDetailViewController(source: viewController!, destination: tabBarController)
    }
    
    // MARK: Navigation
    
    func navigateToMovieDetailViewController(source: BillboardViewController, destination: MovieDetailViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToSomewhere(source: BillboardDataStore, destination: inout MovieDetailDataStore) {
        destination.moviePosition = source.moviePosition
    }
}
