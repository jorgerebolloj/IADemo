//
//  LoginPresenter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol LoginPresentationLogic {
    func presentSuccess()
    func presentError()
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    // MARK: Presenter paths
    
    func presentSuccess() {
        DispatchQueue.main.async {
            self.viewController?.displaySuccess()
        }
    }
    
    func presentError() {
        DispatchQueue.main.async {
            let viewModel = Login.Auth.ViewModel(errorTitle: "", errorMessage: "")
            self.viewController?.displayError(viewModel: viewModel)
        }
    }
}
