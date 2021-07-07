//
//  BillboardPresenter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol BillboardPresentationLogic {
    func presentBillboardSuccess()
    func presentBillboardError(message: String?)
}

class BillboardPresenter: BillboardPresentationLogic {
    weak var viewController: BillboardDisplayLogic?
    
    // MARK: Presenter paths
    
    func presentBillboardSuccess() {
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }
        guard let firstName = UserDefaults.standard.string(forKey: "firstName") else { return }
        guard let lastName = UserDefaults.standard.string(forKey: "lastName") else { return }
        guard let profilePicture = UserDefaults.standard.string(forKey: "profilePicture") else { return }
        guard let cardNumber = UserDefaults.standard.string(forKey: "cardNumber") else { return }
        let name = firstName + " " + lastName
        let viewModel = UserProfile.Info.ViewModel(email: email, name: name,profilePicture: profilePicture, cardNumber: cardNumber)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.viewController?.displayBillboardSuccess(with: viewModel)
        }
    }
    
    func presentBillboardError(message: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            let viewModel = AlertViewController.ErrorViewModel(errorTitle: "errorAlertTitle".localized, errorMessage: message ?? "null")
            self.viewController?.displayBillboardError(viewModel: viewModel)
        }
    }
}
