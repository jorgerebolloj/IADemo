//
//  UserProfilePresenter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol UserProfilePresentationLogic {
    func presentUserProfileSuccess()
    func presentUserProfileError(message: String?)
}

class UserProfilePresenter: UserProfilePresentationLogic {
    weak var viewController: UserProfileDisplayLogic?
    
    // MARK: Presenter paths
    
    func presentUserProfileSuccess() {
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }
        guard let firstName = UserDefaults.standard.string(forKey: "firstName") else { return }
        guard let lastName = UserDefaults.standard.string(forKey: "lastName") else { return }
        guard let profilePicture = UserDefaults.standard.string(forKey: "profilePicture") else { return }
        guard let cardNumber = UserDefaults.standard.string(forKey: "cardNumber") else { return }
        let name = firstName + " " + lastName
        let viewModel = UserProfile.Info.ViewModel(email: email, name: name,profilePicture: profilePicture, cardNumber: cardNumber)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.viewController?.displaySuccess(with: viewModel)
        }
    }
    
    func presentUserProfileError(message: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            let viewModel = AlertViewController.ErrorViewModel(errorTitle: "errorAlertTitle".localized, errorMessage: message ?? "null")
            self.viewController?.displayError(viewModel: viewModel)
        }
    }
}
