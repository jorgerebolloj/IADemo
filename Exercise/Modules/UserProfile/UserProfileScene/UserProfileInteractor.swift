//
//  UserProfileInteractor.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol UserProfileBusinessLogic
{
  func doSomething(request: UserProfile.Something.Request)
}

protocol UserProfileDataStore
{
  //var name: String { get set }
}

class UserProfileInteractor: UserProfileBusinessLogic, UserProfileDataStore
{
  var presenter: UserProfilePresentationLogic?
  var worker: UserProfileWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: UserProfile.Something.Request)
  {
    worker = UserProfileWorker()
    worker?.doSomeWork()
    
    let response = UserProfile.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
