//
//  FavoritesCoordinator.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 4/28/21.
//  Copyright © 2021 dummy. All rights reserved.
//

import Foundation
import UIKit

/// FavoritesCoordinator - Coordinator class for Favorites screen
///
/// Usage:
/// let coordinator = FavoritesCoordinator(navigationController: yourNavigationController)
///
/// Push Favorites screen to navigation stack:
/// coordinator.pushFavoriteList()

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
