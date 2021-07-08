//
//  UserProfileWorker.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

class UserProfileWorker {
    
    // MARK: Worker Tasks
    
    // User Profile
    
    func attemptUserProfileInfo(completion: @escaping ((Bool?, String?) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            WebServicesAPI().getRequestUserProfileInfo() {
                succesful, error in
                if !succesful! {
                    completion(false, error?.localizedDescription)
                } else {
                    completion(true, nil)
                }
            }
        }
    }
    
    // User Cards
    
    func attemptUserTransactionsInfo(requestModel: UserCard.Info.RequestModel, completion: @escaping ((Bool?, String?) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            WebServicesAPI().getRequestUserTransactionsInfo(requestModel: requestModel) {
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
