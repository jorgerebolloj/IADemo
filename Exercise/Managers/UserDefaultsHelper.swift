//
//  UserDefaultsHelper.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//

import Foundation

struct UserDefaultsKeyVal {
    var key: String
    var value: Any
}

class UserDefaultsHelper {
    func setUserDefaultsKeyVals(userDefaultsKeysVals: [UserDefaultsKeyVal]?) {
        guard let userDefaultsKeysVals = userDefaultsKeysVals else { return }
        for userDefaultsKeyVal in userDefaultsKeysVals {
            UserDefaults.standard.set(userDefaultsKeyVal.value, forKey: userDefaultsKeyVal.key)
        }
        UserDefaults.standard.synchronize()
    }
    
    func setUserDefaultsKeyVal(userDefaultsKeyVal: UserDefaultsKeyVal?) {
        guard let userDefaultsKeyVal = userDefaultsKeyVal else { return }
        UserDefaults.standard.set(userDefaultsKeyVal.value, forKey: userDefaultsKeyVal.key)
        UserDefaults.standard.synchronize()
    }
}
