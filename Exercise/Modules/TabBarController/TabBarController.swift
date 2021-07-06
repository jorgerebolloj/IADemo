//
//  TabBarController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            //overrideUserInterfaceStyle = .light
            //self.isModalInPresentation = true
            self.navigationItem.setHidesBackButton(true, animated: false)
        }
        setTabBarProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //setTabBarProperties()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setTabBarProperties() {
        guard let items = tabBar.items else { return }
        items[0].title = "userProfileSectionTitle".localized
        items[1].title = "billboardSectionTitle".localized
        
        //self.navigationController?.navigationBar.isHidden = false
        //let selectedStateImage = ["icon-newsFeed","icon-Materias", "Image"]
        //let unselectedStateImage = selectedStateImage
        /*if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let selectedImage   = selectedStateImage[i]
                let unselectedImage = unselectedStateImage[i]
                /*if TabBarController.gotNews {
                    self.tabBar.items?[0].selectedImage = UIImage(named: "news-notified")?.withRenderingMode(.alwaysOriginal)
                    self.tabBar.items?[0].image = UIImage(named: unselectedImage)?.withRenderingMode(.alwaysOriginal)
                } else {
                    self.tabBar.items?[i].selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
                    self.tabBar.items?[i].image = UIImage(named: unselectedImage)?.withRenderingMode(.alwaysOriginal)
                }*/
            }
        }*/
        //UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
         let tabBarIndex = tabBarController.selectedIndex
         if tabBarIndex == 0 {
         }
         if tabBarIndex == 1 {
         }
         if tabBarIndex == 2 {
         }
    }
}
