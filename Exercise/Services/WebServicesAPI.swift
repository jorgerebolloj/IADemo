//
//  WebServicesAPI.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 05/07/21.
//

import Foundation

class WebServicesAPI {
    
    // MARK: - Login Auth
    
    func getRequestLogin(username: String, password: String, completion: @escaping ((Bool?) -> Void)) {
        requestLogin(username: username, password: password) { response, error  in
            if (response != nil) {
                do {
                    let decodedData = try JSONDecoder().decode(LoginResponseModel.self, from: response!)
                    
                    let userDefaultsAccessTokenKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "accessToken", value: decodedData.accessToken)
                    let userDefaultsTokenTypeKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "tokenType", value: decodedData.tokenType)
                    let userDefaultsKeysVals: [UserDefaultsKeyVal] = [
                        userDefaultsAccessTokenKeyVal,
                        userDefaultsTokenTypeKeyVal]
                    UserDefaultsHelper().setUserDefaultsKeyVals(userDefaultsKeysVals: userDefaultsKeysVals)
                    
                    completion(true)
                } catch let error as NSError {
                    print("Error from login\(error)")
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    func requestLogin(username: String, password: String, completion: @escaping ((Data?, NSError?) -> Void)) {
        let countryCode = ""
        let grantType = ""
        let clientId = ""
        let clientSecret = ""
        let loginEncodableModel = LoginRequestModel(countryCode: countryCode, username: username, password: password, grantType: grantType, clientId: clientId, clientSecret: clientSecret)
        do {
            if #available(iOS 12.0, *) {
                AlamofireManager.sharedInstance.serviceWith(
                    url: Endpoints.login,
                    method: .POST,
                    parameters: loginEncodableModel,
                    auth: false,
                    onCompletion: { response, error in
                        if let errorWeb = error {
                            completion(nil, errorWeb)
                        } else {
                            response != nil ? completion(response, nil) : completion(nil, NSError(domain: "LibraryApi", code: -2, userInfo: nil))
                        }
                    })
            }
        }
    }
}
