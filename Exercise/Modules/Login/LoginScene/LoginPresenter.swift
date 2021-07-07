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
    func presentLoginError(error: NSError?)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    // MARK: Presenter paths
    
    func presentLoginSuccess() {
        DispatchQueue.main.async {
            self.viewController?.displayLoginSuccess()
        }
    }
    
    func presentLoginError(error: NSError?) {
        guard let error = error else {
            errorLoginMessage(message: "wrongDataErrorAlertMessage".localized)
            return
        }
        guard let errorCodeString = error.userInfo["error"] as? String else { return }
        guard let errorMessageString = error.userInfo["error_description"] as? String else { return }
        let errorString = "Código de error: " + errorCodeString + ".\nMensaje de error: " + errorMessageString
        errorLoginMessage(message: errorString)
    }
    
    func errorLoginMessage(message: String) {
        DispatchQueue.main.async {
            let viewModel = AlertViewController.ErrorViewModel(errorTitle: "errorAlertTitle".localized, errorMessage: message)
            self.viewController?.displayLoginError(viewModel: viewModel)
        }
    }
}
