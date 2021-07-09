//
//  LoginInteractor.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol LoginBusinessLogic {
    func userTriesRequestLogin(requestModel: Login.Auth.RequestModel)
}

protocol LoginDataStore {}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    
    // MARK: Interactor management
    
    func userTriesRequestLogin(requestModel: Login.Auth.RequestModel) {
        worker = LoginWorker()
        worker?.attemptLogin(requestModel: requestModel) {
            succesful, error in
                if !succesful! {
                    self.presenter?.presentLoginError(error: error)
                } else {
                    self.presenter?.presentLoginSuccess()
                }
        }
    }
}
