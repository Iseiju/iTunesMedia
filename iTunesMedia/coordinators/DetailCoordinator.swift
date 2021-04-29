//
//  DetailCoordinator.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Foundation
import UIKit

/// DetailCoordinator - Coordinator class for Detail screen
///
/// Usage:
/// let coordinator = DetailCoordinator(navigationController: yourNavigationController)
///
/// Push Detail screen to navigation stack:
/// coordinator.pushDetail(forCellViewModel cellviewModel: MediaCellViewModel)

class DetailCoordinator {
  
  var navigationController: UINavigationController?
  
  convenience init(navigationController: UINavigationController) {
    self.init()
    self.navigationController = navigationController
  }
  
  func pushDetail(forCellViewModel cellViewModel: MediaCellViewModel) {
    guard let detailController = R.storyboard.main.detailController() else { return }
    
    detailController.viewModel = DetailViewModel(cellViewModel: cellViewModel)
    
    navigationController?.pushViewController(detailController, animated: true)
  }
}
