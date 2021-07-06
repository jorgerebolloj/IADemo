//
//  UserProfilePresenter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

protocol UserProfilePresentationLogic
{
  func presentSomething(response: UserProfile.Something.Response)
}

class UserProfilePresenter: UserProfilePresentationLogic
{
  weak var viewController: UserProfileDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: UserProfile.Something.Response)
  {
    let viewModel = UserProfile.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
