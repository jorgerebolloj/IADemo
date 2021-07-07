//
//  BillboardWorker.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

class BillboardWorker {
    
    // MARK: Worker Tasks
    
    func attemptBillboardInfo(completion: @escaping ((Bool?, String?) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            WebServicesAPI().getRequestBillboardInfo() {
                succesful, error in
                if !succesful! {
                    let stringError = self.setError(error: error)
                    completion(false, stringError)
                } else {
                    completion(true, nil)
                }
            }
        }
    }
    
    func setError(error: NSError?) -> String? {
        guard let error = error else {
            return "wrongDataErrorAlertMessage".localized
        }
        let errorCodeString = error.userInfo["error"] as? String ?? "null"
        let errorMessageString = error.userInfo["error_description"] as? String ?? "null"
        let errorString = "Código de error: " + errorCodeString + ".\nMensaje de error: " + errorMessageString
        return errorString
    }
    
}
