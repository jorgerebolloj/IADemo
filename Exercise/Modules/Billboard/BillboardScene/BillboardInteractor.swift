//
//  BillboardInteractor.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol BillboardBusinessLogic {
    func tryRequestBillboard()
}

protocol BillboardDataStore {
  //var name: String { get set }
}

class BillboardInteractor: BillboardBusinessLogic, BillboardDataStore {
    var presenter: BillboardPresentationLogic?
    var worker: BillboardWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func tryRequestBillboard() {
        worker = BillboardWorker()
        worker?.attemptBillboardInfo() {
            succesful, error in
                if !succesful! {
                    self.presenter?.presentBillboardError(message: error)
                } else {
                    self.presenter?.presentBillboardSuccess()
                }
        }
    }
}
