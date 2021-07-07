//
//  LoginRouter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

@objc protocol LoginRoutingLogic {
    func routeToTabBarController(segue: UIStoryboardSegue?)
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    // MARK: Routing
    
    func routeToTabBarController(segue: UIStoryboardSegue?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        /*var userProfileDataStore = userProfileViewController.router!.dataStore!
        passDataToUserProfileViewController(source: dataStore!, destination: &userProfileDataStore)*/
        navigateToTabBarController(source: viewController!, destination: tabBarController)
    }
    
    // MARK: Navigation
    
    func navigateToTabBarController(source: LoginViewController, destination: TabBarController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    /*func passDataToUserProfileViewController(source: LoginDataStore, destination: inout UserProfileDataStore) {
        //destination.name = source.name
    }*/
}
