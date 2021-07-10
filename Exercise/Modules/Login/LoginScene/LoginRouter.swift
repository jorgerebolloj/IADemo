//
//  LoginRouter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

@objc protocol LoginRoutingLogic {
    //func routeToTabBarController()
    //func routeToTabBarController(segue: UIStoryboardSegue?)
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    // MARK: Routing
    
    /*func routeToTabBarController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        navigateToTabBarController(source: viewController!, destination: tabBarController)
    }*/
        
        /*func routeToTabBarController(segue: UIStoryboardSegue?) {
            if let segue = segue {
                let _ = segue.destination as! TabBarController
            }
                //var destinationDS = destinationVC.router!.dataStore!
                //passDataToSomewhere(source: dataStore!, destination: &destinationDS)
           //  } else {
           //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
           //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
           //    var destinationDS = destinationVC.router!.dataStore!
           //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
           //    navigateToSomewhere(source: viewController!, destination: destinationVC)
           //  }
        }*/
    
    // MARK: Navigation
    
    func navigateToTabBarController(source: LoginViewController, destination: TabBarController) {
        source.show(destination, sender: nil)
    }
}
