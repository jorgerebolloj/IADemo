//
//  BillboardViewController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol BillboardDisplayLogic: class {
    func displaySomething(viewModel: Billboard.Something.ViewModel)
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
    }
  
    // MARK: Outlets & variables
  
    @IBOutlet weak var billboardNavigationBar: UINavigationBar!
    
    var loadingViewController: LoadingViewController?
    
    fileprivate func setUI() {
        self.title = "billboardSectionTitle".localized
        //billboardNavigationBar.topItem?.title = "billboardSectionTitle".localized
        //loginButton.setTitle("loginButtonTitle".localized, for: .normal)
        //usernameTextField.placeholder = "usernamePlaceholderText".localized
        //passwordTextField.placeholder = "passwordPlaceholderText".localized
    }
    
    // MARK: User interaction
    
    func doSomething() {
        let request = Billboard.Something.Request()
        interactor?.doSomething(request: request)
    }
  
    // MARK: User response
    
    func displaySomething(viewModel: Billboard.Something.ViewModel) {
        //nameTextField.text = viewModel.name
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
