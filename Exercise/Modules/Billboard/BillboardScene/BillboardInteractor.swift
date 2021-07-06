//
//  BillboardInteractor.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol BillboardBusinessLogic
{
  func doSomething(request: Billboard.Something.Request)
}

protocol BillboardDataStore
{
  //var name: String { get set }
}

class BillboardInteractor: BillboardBusinessLogic, BillboardDataStore
{
  var presenter: BillboardPresentationLogic?
  var worker: BillboardWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Billboard.Something.Request)
  {
    worker = BillboardWorker()
    worker?.doSomeWork()
    
    let response = Billboard.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
