//
//  LoginPresenter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol LoginPresentationLogic {
    func presentLoginSuccess()
    func presentLoginError(error: String?)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    // MARK: Presenter paths
    
    func presentLoginSuccess() {
        DispatchQueue.main.async {
            self.viewController?.displayLoginSuccess()
        }
    }
    
    func presentLoginError(error: String?) {
        guard let error = error else {
            errorLoginMessage(message: "wrongDataErrorAlertMessage".localized)
            return
        }
        errorLoginMessage(message: error)
    }
    
    func errorLoginMessage(message: String) {
        DispatchQueue.main.async {
            let viewModel = AlertViewController.ErrorViewModel(errorTitle: "errorAlertTitle".localized, errorMessage: message)
            self.viewController?.displayLoginError(viewModel: viewModel)
        }
    }
}
