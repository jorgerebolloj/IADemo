//
//  BillboardViewController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol BillboardDisplayLogic: class {
    func displayBillboardSuccess(with viewModel: UserProfile.Info.ViewModel)
    func displayBillboardError(viewModel: AlertViewController.ErrorViewModel)
}

class BillboardViewController: UIViewController, BillboardDisplayLogic {
    var interactor: BillboardBusinessLogic?
    var router: (NSObjectProtocol & BillboardRoutingLogic & BillboardDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = BillboardInteractor()
        let presenter = BillboardPresenter()
        let router = BillboardRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tryRequestBillboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentLoader()
    }
  
    // MARK: Outlets & variables
    
    var loadingViewController: LoadingViewController?
    
    // MARK: UI
    
    fileprivate func setUI() {
        self.title = "billboardSectionTitle".localized
    }
    
    private func presentLoader() {
        loadingViewController = LoadingViewController()
        loadingViewController!.modalPresentationStyle = .overCurrentContext
        loadingViewController!.modalTransitionStyle = .crossDissolve
        present(loadingViewController!, animated: true, completion: nil)
    }
    
    private func dismissLoader(withAlert: Bool, _ viewModel: AlertViewController.ErrorViewModel?) {
        loadingViewController?.dismiss(animated: true, completion: {
            if withAlert {
                guard let viewModel = viewModel else { return }
                self.alertCall(viewModel: viewModel)
            }
        })
    }
    
    // MARK: User interaction
    
    func tryRequestBillboard() {
        interactor?.tryRequestBillboard()
    }
  
    // MARK: User response
    
    func displayBillboardSuccess(with viewModel: UserProfile.Info.ViewModel) {
        dismissLoader(withAlert: false, nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissTabBarLoader"), object: nil)
    }
    
    func displayBillboardError(viewModel: AlertViewController.ErrorViewModel) {
        dismissLoader(withAlert: true, _: viewModel)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissTabBarLoader"), object: viewModel)
    }
    
    func alertCall(viewModel: AlertViewController.ErrorViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let alertView = storyboard.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        alertView.viewModel = viewModel
        alertView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertView, animated: true, completion: nil)
    }
}
