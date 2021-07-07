//
//  TabBarController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//

import UIKit

class TabBarController: UITabBarController {
    var loadingViewController: LoadingViewController?
    var viewModel: AlertViewController.ErrorViewModel?
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.requestDismiss(_:)), name: NSNotification.Name(rawValue: "dismissTabBarLoader"), object: viewModel)
        //presentTabBarLoader()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
    
    private func presentTabBarLoader() {
        self.loadingViewController = LoadingViewController()
        loadingViewController!.modalPresentationStyle = .overCurrentContext
        loadingViewController!.modalTransitionStyle = .crossDissolve
        present(loadingViewController!, animated: true, completion: nil)
    }
    
    @objc func requestDismiss(_ notification: NSNotification) {
        guard let dict = notification.userInfo as NSDictionary? else {
            dismissTabBarLoader(withAlert: false, nil)
            return
        }
        dismissTabBarLoader(withAlert: true, dict)
    }
    
    private func dismissTabBarLoader(withAlert: Bool, _ viewModel: NSDictionary?) {
        self.loadingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func alertCall(viewModel: NSDictionary?) {
        if let dict = viewModel {
            let errorTitle = dict["errorTitle"]
            let errorMessage = dict["errorMessage"]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let alertView = storyboard.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
            alertView.errorTitle = errorTitle as? String
            alertView.errorMessage = errorMessage as? String
            alertView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(alertView, animated: true, completion: nil)
        }
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
