//
//  BillboardViewController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit

protocol BillboardDisplayLogic: class {
    func displayBillboardSuccess(with viewModel: [Billboard.Info.ViewModel]?)
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
        moviesModel = [Billboard.Info.ViewModel]()
        setUI()
        tryRequestBillboard()
    }
  
    // MARK: Outlets & variables
    
    var moviesModel: [Billboard.Info.ViewModel]?
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    private let reuseIdentifier = "MovieCollectionCell"
    private let sectionInsets = UIEdgeInsets(
        top: 20.0,
        left: 20.0,
        bottom: 20.0,
        right: 20.0)
    private let itemsPerRow: CGFloat = 3

    
    // MARK: UI
    
    fileprivate func setUI() {
        self.title = "billboardSectionTitle".localized
    }
    
    // MARK: User interaction
    
    func tryRequestBillboard() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "presentTabBarLoader"), object: nil)
        interactor?.tryRequestBillboard()
    }
  
    // MARK: User response
    
    func displayBillboardSuccess(with viewModel: [Billboard.Info.ViewModel]?) {
        moviesModel = viewModel
        moviesCollectionView.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissTabBarLoader"), object: nil)
    }
    
    func displayBillboardError(viewModel: AlertViewController.ErrorViewModel) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissTabBarLoader"), object: nil)
        self.alertCall(viewModel: viewModel)
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

// MARK: UICollectionViewDataSource

extension BillboardViewController: UICollectionViewDataSource {
  // 1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
  
  // 2
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesModel?.count ?? 0
    }
  
  // 3
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      // 1
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MoviePhotoCell
      // 2
        //let flickrPhoto = photo(for: indexPath)
        //cell.backgroundColor = .white
        cell.movieTitleLabel.text = moviesModel?[indexPath.row].name
      // 3
        //cell.imageView.image = flickrPhoto.thumbnail
        
        return cell
    }

}

// MARK: Collection View Flow Layout Delegate

extension BillboardViewController: UICollectionViewDelegateFlowLayout {
  // 1
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
  
  // 3
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
  
  // 4
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
