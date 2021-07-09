//
//  BillboardViewController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit
import SDWebImage

protocol BillboardDisplayLogic: class {
    func displayBillboardSuccess(with viewModel: [Billboard.Info.ViewModel]?)
    func displayBillboardError(viewModel: AlertViewController.ErrorViewModel)
    func requestMovieDetail()
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
        moviePosition = 0
        setUI()
        tryRequestBillboard()
    }
  
    // MARK: Outlets & variables
    
    var moviesModel: [Billboard.Info.ViewModel]?
    var moviePosition: Int?
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    private let reuseIdentifier = "MovieCollectionCell"
    private let sectionInsets = UIEdgeInsets(
        top: 20.0,
        left: 20.0,
        bottom: 20.0,
        right: 20.0)
    private let itemsPerRow = 3

    
    // MARK: UI
    
    fileprivate func setUI() {
        self.title = "billboardSectionTitle".localized
    }
    
    // MARK: User interaction
    
    func tryRequestBillboard() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "presentTabBarLoader"), object: nil)
        interactor?.tryRequestBillboard()
    }
    
    func userTryToRequestMovieDetail(movieSelected: Int) {
        interactor?.tryToRequestMovieDetail(movieSelected: movieSelected)
    }
    
    func requestMovieDetail() {
        router?.tryToRequestMovieDetail()
    }
  
    // MARK: User response
    
    func displayBillboardSuccess(with viewModel: [Billboard.Info.ViewModel]?) {
        moviesModel = viewModel
        moviesCollectionView.reloadData()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MoviePhotoCell
        
        cell.movieTitleLabel.text = moviesModel?[indexPath.row].name
        let url = (moviesModel?[indexPath.row].poster) ?? ""
        cell.moviePhotoImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "imageMockUp.png"))
        
        return cell
    }

}

// MARK: Collection View Flow Layout Delegate

extension BillboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(UIScreen.main.bounds.width)
        let side = width / itemsPerRow
        let rem = width % itemsPerRow
        let addOne = indexPath.row % itemsPerRow < rem
        let ceilWidth = addOne ? side + 1 : side
        return CGSize(width: ceilWidth, height: side)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieSelected = moviesModel?[indexPath.row]
        let posibleMoviePosition = movieSelected?.position
        guard let moviePosition = posibleMoviePosition else { return }
        userTryToRequestMovieDetail(movieSelected: moviePosition)
    }
}
