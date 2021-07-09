//
//  UserProfileRouter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

@objc protocol UserProfileRoutingLogic {}

protocol UserProfileDataPassing {
  var dataStore: UserProfileDataStore? { get }
}

class UserProfileRouter: NSObject, UserProfileRoutingLogic, UserProfileDataPassing {
  weak var viewController: UserProfileViewController?
  var dataStore: UserProfileDataStore?
}
