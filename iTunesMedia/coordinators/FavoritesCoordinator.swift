//
//  FavoritesCoordinator.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 4/28/21.
//  Copyright © 2021 dummy. All rights reserved.
//

import Foundation
import UIKit

class FavoritesCoordinator {
  
  var navigationController: UINavigationController?
  
  convenience init(navigationController: UINavigationController) {
    self.init()
    self.navigationController = navigationController
  }
  
  func pushFavoriteList() {
    guard let favoritesController = R.storyboard.main.favoriteListController() else { return }
    
    favoritesController.viewModel = FavoriteViewModel()
    
    navigationController?.pushViewController(favoritesController, animated: true)
  }
}
