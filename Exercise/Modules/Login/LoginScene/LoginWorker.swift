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
    
    func attemptLogin(requestModel: Login.Auth.RequestModel, completion: @escaping ((Bool?, String?) -> Void)) {
        let username = requestModel.username
        let password = requestModel.password
        
        if (username.isEmpty) {
            completion(false, nil)
            return
        }
        
        if (password.isEmpty) {
            completion(false, nil)
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).sync {
            WebServicesAPI().getRequestLogin(requestModel: requestModel) {
                succesful, error in
                if !succesful! {
                    completion(false, error?.localizedDescription)
                } else {
                    completion(true, nil)
                }
            }
        }
    }
}
