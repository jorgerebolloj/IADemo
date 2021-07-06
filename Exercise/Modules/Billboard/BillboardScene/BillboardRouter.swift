//
//  BillboardRouter.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

@objc protocol BillboardRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol BillboardDataPassing
{
  var dataStore: BillboardDataStore? { get }
}

class BillboardRouter: NSObject, BillboardRoutingLogic, BillboardDataPassing
{
  weak var viewController: BillboardViewController?
  var dataStore: BillboardDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: BillboardViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: BillboardDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
