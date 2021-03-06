//
//  WebServicesAPI.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 05/07/21.
//

import Foundation

class WebServicesAPI {
    var billboardWorker: BillboardWorker?
    var userProfileWorker: UserProfileWorker?
    
    // MARK: - Login Auth
    
    // MARK: Request
    
    func requestLogin(loginEncodableModel: Login.Auth.RequestWSModel, completion: @escaping ((Data?, NSError?) -> Void)) {
        do {
            if #available(iOS 12.0, *) {
                AlamofireManager.sharedInstance.serviceWith (
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
        let loginEncodableModel = prepareLoginModel(withRequestModel: requestModel)
        requestLogin(loginEncodableModel: loginEncodableModel) { response, error  in
            if (response != nil) {
                do {
                    let decodedData = try JSONDecoder().decode(Login.Auth.ResponseWSModel.self, from: response!)
                    let realmAPIInstance = RealmApi()
                    realmAPIInstance.getDefaultConfig("\(decodedData.username)")
                    self.storeLoginResponseData(responseData: decodedData)
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
    
    private func prepareLoginModel(withRequestModel requestModel: Login.Auth.RequestModel) -> Login.Auth.RequestWSModel {
        let countryCode = Globals().countryCode
        let grantType = Globals().grantType
        let clientId = Globals().clientId
        let clientSecret = Globals().clientSecret
        let loginEncodableModel = Login.Auth.RequestWSModel(country_code: countryCode, username: requestModel.username, password: requestModel.password, grant_type: grantType, client_id: clientId, client_secret: clientSecret)
        return loginEncodableModel
    }
    
    // MARK: Store response data
    
    private func storeLoginResponseData(responseData decodedData: Login.Auth.ResponseWSModel) {
        let userDefaultsAccessTokenKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "accessToken", value: decodedData.accessToken)
        let userDefaultsTokenTypeKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "tokenType", value: decodedData.tokenType)
        let userDefaultsKeysVals: [UserDefaultsKeyVal] = [
            userDefaultsAccessTokenKeyVal,
            userDefaultsTokenTypeKeyVal]
        UserDefaultsHelper().setUserDefaultsKeyVals(userDefaultsKeysVals: userDefaultsKeysVals)
    }
    
    // MARK: - User Profile Info
    
    // MARK: Request
    
    func requestUserProfileInfo(completion: @escaping ((Data?, NSError?) -> Void)) {
        do {
            if #available(iOS 12.0, *) {
                AlamofireManager.sharedInstance.serviceWith (
                    url: Endpoints.userProfile,
                    method: .GET,
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
    
    func getRequestUserProfileInfo(completion: @escaping ((Bool?, NSError?) -> Void)) {
        requestUserProfileInfo() { response, error  in
            if (response != nil) {
                do {
                    let decodedData = try JSONDecoder().decode(UserProfile.Info.ResponseWSModel.self, from: response!)
                    self.userProfileWorker = UserProfileWorker()
                    self.userProfileWorker?.storeUserProfileResponseData(responseData: decodedData)
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
    
    // MARK: - User Transactions Info
    
    // MARK: Request
    
    func requestUserTransactionsInfo(userCardEncodableModel: UserCard.Info.RequestWSModel, completion: @escaping ((Data?, NSError?) -> Void)) {
        do {
            if #available(iOS 12.0, *) {
                AlamofireManager.sharedInstance.serviceWith (
                    url: Endpoints.cardTransactions,
                    method: .POST,
                    parameters: userCardEncodableModel,
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
    
    func getRequestUserTransactionsInfo(requestModel: UserCard.Info.RequestModel, completion: @escaping ((Bool?, NSError?) -> Void)) {
        let userCardEncodableModel = prepareUserCardModel(withRequestModel: requestModel)
        requestUserTransactionsInfo(userCardEncodableModel: userCardEncodableModel) { response, error  in
            if (response != nil) {
                do {
                    let decodedData = try JSONDecoder().decode(UserCard.Info.ResponseWSModel.self, from: response!)
                    self.storeUserTransactionsResponseData(responseData: decodedData)
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
    
    private func prepareUserCardModel(withRequestModel requestModel: UserCard.Info.RequestModel) -> UserCard.Info.RequestWSModel {
        let countryCode = Globals().countryCode
        let pin = Globals().pin
        let userCardEncodableModel = UserCard.Info.RequestWSModel(card_number: requestModel.cardNumber, country_code: countryCode, pin: pin, transaction_include: true)
        return userCardEncodableModel
    }
    
    // MARK: Store response data
    
    private func storeUserTransactionsResponseData(responseData decodedData: UserCard.Info.ResponseWSModel) {}
    
    // MARK: - Billboard Info
    
    // MARK: Request
    
    func requestBillboardInfo(completion: @escaping ((Data?, NSError?) -> Void)) {
        do {
            if #available(iOS 12.0, *) {
                AlamofireManager.sharedInstance.serviceWith (
                    url: Endpoints.billboard,
                    method: .GET,
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
    
    func getRequestBillboardInfo(completion: @escaping ((Bool?, NSError?) -> Void)) {
        requestBillboardInfo() { response, error  in
            if (response != nil) {
                do {
                    let decodedData = try JSONDecoder().decode(Billboard.Info.ResponseWSModel.self, from: response!)
                    self.billboardWorker = BillboardWorker()
                    self.billboardWorker?.storeBillboardResponseData(responseData: decodedData)
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
}
