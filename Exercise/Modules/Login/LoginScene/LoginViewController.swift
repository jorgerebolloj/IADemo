//
//  LoginViewController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol LoginDisplayLogic: class {
    func displaySuccess()
    func displayError(viewModel: Login.Auth.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
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
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
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
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonAction(_ sender: Any) {
        userTriesRequestLogin()
    }
    
    var loadingViewController: LoadingViewController?
    
    fileprivate func setUI() {
        loginButton.setTitle("loginButtonTitle".localized, for: .normal)
        usernameTextField.placeholder = "usernamePlaceholderText".localized
        passwordTextField.placeholder = "passwordPlaceholderText".localized
    }
    
    // MARK: User interaction
    
    private func presentLoader() {
        loadingViewController = LoadingViewController()
        loadingViewController!.modalPresentationStyle = .overCurrentContext
        loadingViewController!.modalTransitionStyle = .crossDissolve
        present(loadingViewController!, animated: true, completion: nil)
    }
    
    private func dismissLoader(withAlert: Bool, _ viewModel: Login.Auth.ViewModel?) {
        loadingViewController?.dismiss(animated: true, completion: {
            if withAlert {
                guard let viewModel = viewModel else { return }
                self.alertCall(viewModel: viewModel)
            }
        })
    }
    
    func userTriesRequestLogin() {
        presentLoader()
        let username = "pruebas_beto_ia@yahoo.com" //usernameTextField.text ?? ""
        let password = "Pruebas01" //passwordTextField.text ?? ""
        let requestModel = Login.Auth.RequestModel(username: username, password: password)
        interactor?.userTriesRequestLogin(requestModel: requestModel)
    }
    
    // MARK: User response
    
    func displayError(viewModel: Login.Auth.ViewModel) {
        dismissLoader(withAlert: true, _: viewModel)
    }
    
    func displaySuccess() {
        dismissLoader(withAlert: false, nil)
        router?.routeToTabBarController(segue: nil)
    }
    
    func alertCall(viewModel: Login.Auth.ViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let alertView = storyboard.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        alertView.viewModel = viewModel
        alertView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertView, animated: true, completion: nil)
    }
}
