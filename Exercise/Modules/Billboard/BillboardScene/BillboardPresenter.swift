//
//  BillboardPresenter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol BillboardPresentationLogic
{
  func presentSomething(response: Billboard.Something.Response)
}

class BillboardPresenter: BillboardPresentationLogic
{
  weak var viewController: BillboardDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Billboard.Something.Response)
  {
    let viewModel = Billboard.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
