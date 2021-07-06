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
    
    fileprivate func setUI() {
        loginButton.setTitle("loginButtonTitle".localized, for: .normal)
        usernameTextField.placeholder = "usernamePlaceholderText".localized
        passwordTextField.placeholder = "passwordPlaceholderText".localized
    }
    
    // MARK: User interaction
    
    func userTriesRequestLogin() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let requestModel = Login.Auth.RequestModel(username: username, password: password)
        interactor?.userTriesRequestLogin(requestModel: requestModel)
    }
    
    // MARK: User response
    
    func displayError(viewModel: Login.Auth.ViewModel) {
        alertCall(title: viewModel.errorTitle, message: viewModel.errorMessage, ViewController: self, toFocus: passwordTextField)
    }
    
    func displaySuccess() {
        // Perform view
    }
    
    func alertCall(title: String, message: String, ViewController: UIViewController, toFocus: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "alertConfirmationButton".localized, style: UIAlertAction.Style.cancel,handler: {_ in
            toFocus.becomeFirstResponder()
        });
        alert.addAction(action)
        ViewController.present(alert, animated: true, completion:nil)
    }
}
