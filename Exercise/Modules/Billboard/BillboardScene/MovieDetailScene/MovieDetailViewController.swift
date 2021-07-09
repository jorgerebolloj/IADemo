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
    func displayMovieDetails(viewModel: MovieDetail.Info.ViewModel)
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
        movieURL = ""
        setUI()
        tryRequestMovieDetails()
    }
    
    // MARK: Outlets & variables
    
    var playerController = AVPlayerViewController()
    var movieURL: String?
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBAction func moviePlayButtonAction(_ sender: Any) {
        let videoURL = URL(string: movieURL!)
        let player = AVPlayer(url: videoURL!)
        
        playerController = AVPlayerViewController()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MovieDetailViewController.didfinishplaying(note:)),name:NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        playerController.player = player
        playerController.allowsPictureInPicturePlayback = true
        playerController.delegate = self
        
        self.present(playerController,animated: true) {
            self.playerController.player?.play()
        }
    }
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieLengthLabel: UILabel!
    @IBOutlet weak var movieSynopsisTexView: UITextView!
    
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
    
    func tryRequestMovieDetails() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "presentTabBarLoader"), object: nil)
        interactor?.tryRequestMovieDetails()
    }
    
    // MARK: User response
    
    func displayMovieDetails(viewModel: MovieDetail.Info.ViewModel) {
        movieURL = viewModel.movieVideo
        moviePosterImageView.sd_setImage(with: URL(string: viewModel.moviePoster), placeholderImage: UIImage(named: "imageMockUp.png"))
        movieNameLabel.text = viewModel.movieName
        movieRatingLabel.text = viewModel.movieRating
        movieGenreLabel.text = viewModel.movieGenre
        movieLengthLabel.text = viewModel.movieLength
        movieSynopsisTexView.text = viewModel.movieSynopsis
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissTabBarLoader"), object: nil)
    }
}
