//
//  AlertViewController.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//

import Foundation
import UIKit

class AlertViewController: UIViewController {
    var viewModel: AlertViewController.ErrorViewModel?
    var errorTitle: String?
    var errorMessage: String?
    
    @IBOutlet weak var alertBackgroundView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertMessage: UILabel!
    @IBOutlet weak var alertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    fileprivate func setUI() {
        guard let errorTitle = viewModel?.errorTitle else { return }
        guard let errorMessage = viewModel?.errorMessage else { return }
        alertTitle.text = errorTitle
        alertMessage.text = errorMessage
        alertButton.setTitle("alertConfirmationButton".localized, for: .normal)
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    struct ErrorViewModel {
        var errorTitle: String
        var errorMessage: String
    }
}
