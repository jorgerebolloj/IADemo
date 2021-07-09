//
//  LoginViewController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol LoginDisplayLogic: class {
    func displayLoginSuccess()
    func displayLoginError(viewModel: AlertViewController.ErrorViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic, UITextFieldDelegate {
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Outlets & variables
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonAction(_ sender: Any) {
        passwordTextField.resignFirstResponder()
        userTriesRequestLogin()
    }
    
    var loadingViewController: LoadingViewController?
    var activeTextField : UITextField? = nil
    
    fileprivate func setUI() {
        loginButton.setTitle("loginButtonTitle".localized, for: .normal)
        loginButton.roundedBorder()
        usernameTextField.placeholder = "usernamePlaceholderText".localized
        passwordTextField.placeholder = "passwordPlaceholderText".localized
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: UI
    
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
    
    func userTriesRequestLogin() {
        presentLoader()
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let requestModel = Login.Auth.RequestModel(username: username, password: password)
        interactor?.userTriesRequestLogin(requestModel: requestModel)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        var shouldMoveViewUp = false
        
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }

        if(shouldMoveViewUp) {
          self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            userTriesRequestLogin()
        }
        return true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: User response
    
    func displayLoginSuccess() {
        dismissLoader(withAlert: false, nil)
        
        let sceneDeleage = SceneDelegate.shared
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController : UIViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        tabBarController.modalPresentationStyle = .fullScreen
        sceneDeleage?.window?.makeKeyAndVisible()
        sceneDeleage?.window?.rootViewController?.present(tabBarController, animated: true, completion: nil)
    }
    
    func displayLoginError(viewModel: AlertViewController.ErrorViewModel) {
        dismissLoader(withAlert: true, _: viewModel)
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
