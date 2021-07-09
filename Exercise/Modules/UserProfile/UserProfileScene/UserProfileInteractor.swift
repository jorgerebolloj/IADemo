//
//  UserProfileInteractor.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol UserProfileBusinessLogic {
    func tryRequestUserProfile()
    func tryRequestUserTransactions(requestModel: UserCard.Info.RequestModel)
}

protocol UserProfileDataStore {}

class UserProfileInteractor: UserProfileBusinessLogic, UserProfileDataStore {
    var presenter: UserProfilePresentationLogic?
    var worker: UserProfileWorker?
    
    // MARK: Interactor management
    
    // User Profile
    
    func tryRequestUserProfile() {
        worker = UserProfileWorker()
        worker?.attemptUserProfileInfo() {
            succesful, error in
                if !succesful! {
                    self.presenter?.presentUserProfileError(message: error)
                } else {
                    self.presenter?.presentUserProfileSuccess()
                }
        }
    }
    
    // User Card
    
    func tryRequestUserTransactions(requestModel: UserCard.Info.RequestModel) {
        worker = UserProfileWorker()
        worker?.attemptUserTransactionsInfo(requestModel: requestModel) {
            succesful, error in
                if !succesful! {
                    self.presenter?.presentUserProfileError(message: error)
                } else {
                    self.presenter?.presentUserProfileSuccess()
                }
        }
    }
}
