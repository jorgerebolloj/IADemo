//
//  TabBarController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    var loadingViewController: LoadingViewController?
    var viewModel: AlertViewController.ErrorViewModel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.navigationItem.setHidesBackButton(true, animated: false)
            self.delegate = self
        }
        setTabBarProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.requestDismiss), name: NSNotification.Name(rawValue: "dismissTabBarLoader"), object: viewModel)
        NotificationCenter.default.addObserver(self, selector: #selector(self.presentTabBarLoader), name: NSNotification.Name(rawValue: "presentTabBarLoader"), object: viewModel)
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
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    @objc func presentTabBarLoader() {
        self.loadingViewController = LoadingViewController()
        loadingViewController!.modalPresentationStyle = .overCurrentContext
        loadingViewController!.modalTransitionStyle = .crossDissolve
        present(loadingViewController!, animated: true, completion: nil)
    }
    
    @objc func requestDismiss() {
        dismissTabBarLoader()
    }
    
    private func dismissTabBarLoader() {
        self.loadingViewController?.dismiss(animated: true, completion: nil)
    }
}
