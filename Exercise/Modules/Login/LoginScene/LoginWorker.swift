//
//  LoginWorker.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

class LoginWorker {
    
    // MARK: Worker Tasks
    
    func attemptLogin(requestModel: Login.Auth.RequestModel, completion: @escaping ((Bool?) -> Void)) {
        let username = requestModel.username
        let password = requestModel.password
        
        if (password.isEmpty) {
            completion(false)
        }
        
        if (username.isEmpty) {
            completion(false)
        }
        
        DispatchQueue.global(qos: .background).async {
            WebServicesAPI().getRequestLogin(requestModel:requestModel) {
                succesful in
                if !succesful! {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
}