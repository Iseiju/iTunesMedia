//
//  LandingController.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import UIKit

class LandingController: UIViewController {

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    startAnimation()
    toMainScreen()
  }

  private func startAnimation() {
    UIView.animate(withDuration: 0.4) { [weak self] in
      self?.activityIndicator.isHidden = false
      self?.activityIndicator.startAnimating()
    }
  }

  private func toMainScreen() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      let mainCoordinator = MainCoordinator(presentedController: self)
      mainCoordinator.presentMain()
    }
  }
}
