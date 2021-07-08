//
//  MovieDetailViewController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 08/07/21.
//
//

import UIKit
import AVFoundation
import AVKit

protocol MovieDetailDisplayLogic: class {
    func displaySomething(viewModel: MovieDetail.Something.ViewModel)
}

class MovieDetailViewController: UIViewController, MovieDetailDisplayLogic {
    var interactor: MovieDetailBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailRoutingLogic & MovieDetailDataPassing)?
    
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
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        let router = MovieDetailRouter()
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
    
    override func viewDidAppear(_ animated: Bool) {
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
    // MARK: Outlets & variables
    
    // MARK: UI
    
    fileprivate func setUI() {
        self.title = "movieDetailSectionTitle".localized
    }
    
    // MARK: User interaction
    
    func doSomething() {
        let request = MovieDetail.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    // MARK: User response
    
    func displaySomething(viewModel: MovieDetail.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
