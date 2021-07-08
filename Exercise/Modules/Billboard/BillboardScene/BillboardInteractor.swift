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
}

protocol BillboardDataStore {
  //var name: String { get set }
}

class BillboardInteractor: BillboardBusinessLogic, BillboardDataStore {
    var presenter: BillboardPresentationLogic?
    var worker: BillboardWorker?
    let queue = DispatchQueue(label: "billboard")
    //var name: String = ""
    
    // MARK: Do something
    
    func tryRequestBillboard() {
        worker = BillboardWorker()
        worker?.attemptBillboardInfo() {
            succesful, error in
                if !succesful! {
                    self.presenter?.presentBillboardError(message: error)
                } else {
                    self.queue.async {
                        self.worker?.queryRouteData()
                    }
                    var moviesModel: Results<Object>?
                    self.queue.async {
                        moviesModel = self.worker?.queryMovieData()
                    }
                    self.queue.async {
                        self.presenter?.presentBillboardSuccess(moviesModel: moviesModel)
                    }
                }
        }
    }
}
