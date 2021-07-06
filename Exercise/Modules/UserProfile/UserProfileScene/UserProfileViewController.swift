//
//  UserProfileViewController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol UserProfileDisplayLogic: class {
    func displaySomething(viewModel: UserProfile.Something.ViewModel)
}

class UserProfileViewController: UIViewController, UserProfileDisplayLogic {
    var interactor: UserProfileBusinessLogic?
    var router: (NSObjectProtocol & UserProfileRoutingLogic & UserProfileDataPassing)?
    
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
        let interactor = UserProfileInteractor()
        let presenter = UserProfilePresenter()
        let router = UserProfileRouter()
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
    
    @IBOutlet weak var userProfileNavigationBar: UINavigationBar!
    @IBOutlet weak var userPictureImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userCardLabel: UILabel!
    
    var loadingViewController: LoadingViewController?
    
    fileprivate func setUI() {
        self.title = "userProfileSectionTitle".localized
        userProfileNavigationBar.topItem?.title = "userProfileSectionTitle".localized
        welcomeLabel.text = "welcomeLabel".localized
        userNameLabel.text = ""
        emailLabel.text = "emailLabel".localized
        userEmailLabel.text = ""
        userCardLabel.text = "cardLabel".localized + ""
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
    
    func doSomething() {
        let request = UserProfile.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    // MARK: User response
    
    func displaySomething(viewModel: UserProfile.Something.ViewModel) {
        //nameTextField.text = viewModel.name
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
