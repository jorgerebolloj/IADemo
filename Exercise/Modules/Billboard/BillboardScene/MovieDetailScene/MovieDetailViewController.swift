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

class MovieDetailViewController: UIViewController, MovieDetailDisplayLogic, AVPlayerViewControllerDelegate {
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
    
    // MARK: Outlets & variables
    
    var playerController = AVPlayerViewController()
    var movieURL: String?
    
    @IBAction func Play(_ sender: Any) {
        /*let path = Bundle.main.path(forResource: "video", ofType: "mp4")
        let url = NSURL(fileURLWithPath: path!)*/
        let videoURL = URL(string: movieURL!)
        let player = AVPlayer(url: videoURL!)
        
        playerController = AVPlayerViewController()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MovieDetailViewController.didfinishplaying(note:)),name:NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        playerController.player = player
        playerController.allowsPictureInPicturePlayback = true
        playerController.delegate = self
        playerController.player?.play()
        
        self.present(playerController,animated:true,completion:nil)
    }
    
    // MARK: UI
    
    fileprivate func setUI() {
        self.title = "movieDetailSectionTitle".localized
    }
    
    @objc func didfinishplaying(note : NSNotification) {
        let alertview = UIAlertController(title:"finished",message:"video finished",preferredStyle: .alert)
        alertview.addAction(UIAlertAction(title:"Ok",style: .default, handler: nil))
        self.present(alertview,animated:true,completion: nil)
    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        let currentviewController =  navigationController?.visibleViewController
        
        if currentviewController != playerViewController {
            currentviewController?.present(playerViewController,animated: true,completion:nil)
        }
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