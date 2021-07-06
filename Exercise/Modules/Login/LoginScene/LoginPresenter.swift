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
    func presentError(error: NSError?)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    // MARK: Presenter paths
    
    func presentSuccess() {
        DispatchQueue.main.async {
            self.viewController?.displaySuccess()
        }
    }
    
    func presentError(error: NSError?) {
        guard let error = error else {
            errorMessage(message: "wrongDataErrorAlertMessage".localized)
            return
        }
        guard let errorCodeString = error.userInfo["error"] as? String else { return }
        guard let errorMessageString = error.userInfo["error_description"] as? String else { return }
        let errorString = "Código de error: " + errorCodeString + ". Mensaje de error: " + errorMessageString
        errorMessage(message: errorString)
    }
    
    func errorMessage(message: String) {
        DispatchQueue.main.async {
            let viewModel = Login.Auth.ViewModel(errorTitle: "errorAlertTitle".localized, errorMessage: message)
            self.viewController?.displayError(viewModel: viewModel)
        }
    }
}
