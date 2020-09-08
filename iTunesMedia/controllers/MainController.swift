//
//  MainController.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import UIKit

class MainController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    initViews()
  }
  
  private func initViews() {
    navigationController?.navigationBar.barTintColor = .white
    navigationController?
      .navigationBar
      .titleTextAttributes = [NSAttributedString.Key.foregroundColor: R.color.accentColor() ?? UIColor()]
  }
}
