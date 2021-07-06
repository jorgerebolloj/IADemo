//
//  WebServicesAPI.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 05/07/21.
//

import Foundation

class WebServicesAPI {
    
    // MARK: - Login Auth
    
    // MARK: Request
    
    func requestLogin(loginEncodableModel: Login.Auth.RequestWSModel, completion: @escaping ((Data?, NSError?) -> Void)) {
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
    
    // MARK: Response
    
    func getRequestLogin(requestModel: Login.Auth.RequestModel, completion: @escaping ((Bool?, NSError?) -> Void)) {
        let loginEncodableModel = prepareModel(withRequestModel: requestModel)
        requestLogin(loginEncodableModel: loginEncodableModel) { response, error  in
            if (response != nil) {
                do {
                    let decodedData = try JSONDecoder().decode(Login.Auth.ResponseWSModel.self, from: response!)
                    self.storeResponseData(responseData: decodedData)
                    completion(true, nil)
                } catch let error as NSError {
                    print("Error from login\(error)")
                    completion(false, NSError(domain: "LibraryApi", code: -2, userInfo: nil))
                }
            } else {
                completion(false, NSError(domain: "LibraryApi", code: error?.code ?? -2, userInfo: error?.userInfo))
            }
        }
    }
    
    // MARK: Prepare model to request
    
    private func prepareModel(withRequestModel requestModel: Login.Auth.RequestModel) -> Login.Auth.RequestWSModel {
        let countryCode = Globals().countryCode
        let grantType = Globals().grantType
        let clientId = Globals().clientId
        let clientSecret = Globals().clientSecret
        let loginEncodableModel = Login.Auth.RequestWSModel(country_code: countryCode, username: requestModel.username, password: requestModel.password, grant_type: grantType, client_id: clientId, client_secret: clientSecret)
        return loginEncodableModel
    }
    
    // MARK: Store response data
    
    private func storeResponseData(responseData decodedData: Login.Auth.ResponseWSModel) {
        let userDefaultsAccessTokenKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "accessToken", value: decodedData.accessToken)
        let userDefaultsTokenTypeKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "tokenType", value: decodedData.tokenType)
        let userDefaultsKeysVals: [UserDefaultsKeyVal] = [
            userDefaultsAccessTokenKeyVal,
            userDefaultsTokenTypeKeyVal]
        UserDefaultsHelper().setUserDefaultsKeyVals(userDefaultsKeysVals: userDefaultsKeysVals)
    }
}
