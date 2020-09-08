//
//  DetailCoordinator.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Foundation
import UIKit

class DetailCoordinator {
  
  var navigationController: UINavigationController?
  
  convenience init(navigationController: UINavigationController) {
    self.init()
    self.navigationController = navigationController
  }
  
  func pushDetail() {
    guard let detailController = R.storyboard.main.detailController() else { return }
    
    navigationController?.pushViewController(detailController, animated: true)
  }
}
