//
//  BillboardInteractor.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit
import RealmSwift

protocol BillboardBusinessLogic {
    func tryRequestBillboard()
    func tryToRequestMovieDetail(movieSelected: Int)
}

protocol BillboardDataStore {
    var moviePosition: Int { get set }
}

class BillboardInteractor: BillboardBusinessLogic, BillboardDataStore {
    var presenter: BillboardPresentationLogic?
    var worker: BillboardWorker?
    var moviePosition = 0
    
    // MARK: Do something
    
    func tryRequestBillboard() {
        worker = BillboardWorker()
        worker?.attemptBillboardInfo() {
            succesful, error in
                if !succesful! {
                    self.presenter?.presentBillboardError(message: error)
                } else {
                    self.worker?.queryRouteData()
                    var moviesModel: Results<Object>?
                    moviesModel = self.worker?.queryMovieData()
                    self.presenter?.presentBillboardSuccess(moviesModel: moviesModel)
                }
        }
    }
    
    func tryToRequestMovieDetail(movieSelected: Int) {
        moviePosition = movieSelected
        presenter?.requestMovieDetail()
    }
}
