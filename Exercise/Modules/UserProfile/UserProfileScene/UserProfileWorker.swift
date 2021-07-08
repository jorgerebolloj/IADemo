//
//  UserProfileWorker.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

class UserProfileWorker {
    
    let queue = DispatchQueue(label: "userProfile")
    
    // MARK: Worker Tasks
    
    // User Profile
    
    func attemptUserProfileInfo(completion: @escaping ((Bool?, String?) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).sync {
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
        DispatchQueue.global(qos: .userInitiated).sync {
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
    
    // MARK: Store response data
    
    func storeUserProfileResponseData(responseData decodedData: UserProfile.Info.ResponseWSModel) {
            autoreleasepool {
                let userDefaultsEmailKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "email", value: decodedData.email)
                let userDefaultsFirstNameKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "firstName", value: decodedData.firstName)
                let userDefaultsLastNameKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "lastName", value: decodedData.lastName)
                let userDefaultsPhoneNumberKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "phoneNumber", value: decodedData.phoneNumber)
                let userDefaultsProfilePictureKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "profilePicture", value: decodedData.profilePicture)
                let userDefaultsCardNumberKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "cardNumber", value: decodedData.cardNumber)
                let userDefaultsKeysVals: [UserDefaultsKeyVal] = [
                    userDefaultsEmailKeyVal,
                    userDefaultsFirstNameKeyVal,
                    userDefaultsLastNameKeyVal,
                    userDefaultsPhoneNumberKeyVal,
                    userDefaultsProfilePictureKeyVal,
                    userDefaultsCardNumberKeyVal]
                UserDefaultsHelper().setUserDefaultsKeyVals(userDefaultsKeysVals: userDefaultsKeysVals)
            }
    }
}
