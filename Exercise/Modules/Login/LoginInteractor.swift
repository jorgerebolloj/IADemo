//
//  LoginInteractor.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol LoginBusinessLogic
{
  func doSomething(request: Login.Something.Request)
}

protocol LoginDataStore
{
  //var name: String { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore
{
  var presenter: LoginPresentationLogic?
  var worker: LoginWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Login.Something.Request)
  {
    worker = LoginWorker()
    worker?.doSomeWork()
    
    let response = Login.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
