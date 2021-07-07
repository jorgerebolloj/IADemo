//
//  UserProfileViewController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol UserProfileDisplayLogic: class {
    func displayUserProfileSuccess(with viewModel: UserProfile.Info.ViewModel)
    func displayUserProfileError(viewModel: AlertViewController.ErrorViewModel)
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
        tryRequestUserProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentLoader()
    }
    
    // MARK: Outlets & variables
    
    @IBOutlet weak var userPictureImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userCardLabel: UILabel!
    @IBOutlet weak var userCardTextField: UITextField!
    @IBOutlet weak var userCardTransactionButton: UIButton!
    
    @IBAction func userCardTransactionButtonAction(_ sender: Any) {
        tryRequestUserTransactions()
    }
    
    var loadingViewController: LoadingViewController?
    
    // MARK: UI
    
    fileprivate func setUI() {
        self.title = "userProfileSectionTitle".localized
        userPictureImage.image = UIImage(named: "userPicture")
        welcomeLabel.text = "welcomeLabel".localized
        userNameLabel.text = ""
        emailLabel.text = "emailLabel".localized
        userEmailLabel.text = ""
        userCardLabel.text = "cardLabel".localized
        userCardTextField.text = ""
        userCardTransactionButton.setTitle("userCardTransactionButtonLabel".localized, for: .normal)
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
    
    // User Profile
    
    func tryRequestUserProfile() {
        interactor?.tryRequestUserProfile()
    }
    
    // User Card
    
    func tryRequestUserTransactions() {
        presentLoader()
        guard let cardNumber = (userCardLabel.text != nil) ? userCardTextField.text : "" else { return }
        let requestModel = UserCard.Info.RequestModel(cardNumber: cardNumber)
        interactor?.tryRequestUserTransactions(requestModel: requestModel)
    }
    
    // MARK: User response
    
    // User Profile
    
    func displayUserProfileSuccess(with viewModel: UserProfile.Info.ViewModel) {
        dismissLoader(withAlert: false, nil)
        userNameLabel.text = viewModel.name
        userEmailLabel.text = viewModel.email
        userCardTextField.text = viewModel.cardNumber
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissTabBarLoader"), object: nil)
    }
    
    func displayUserProfileError(viewModel: AlertViewController.ErrorViewModel) {
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
    
    // User Card
    
    
}
