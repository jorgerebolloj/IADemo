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

protocol LoginDataStore {
    //var name: String { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    //var name: String = ""
    
    // MARK: Interactor management
    
    func userTriesRequestLogin(requestModel: Login.Auth.RequestModel) {
        worker = LoginWorker()
        worker?.attemptLogin(requestModel: requestModel) {
            succesful in
                if !succesful! {
                    self.presenter?.presentError()
                } else {
                    self.presenter?.presentSuccess()
                }
        }
    }
}