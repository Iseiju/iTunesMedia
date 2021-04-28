//
//  MainCoordinator.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator {
  
  var presentedController: UIViewController?
  
  convenience init(presentedController: UIViewController) {
    self.init()
    self.presentedController = presentedController
  }
  
  func presentMain() {
    guard let mainController = R.storyboard.main.mainController() else { return }
    
    mainController.viewModel = MainViewModel()
    mainController.delegate = self
    
    let navigationController = UINavigationController(rootViewController: mainController)
    navigationController.modalPresentationStyle = .fullScreen
    
    presentedController?.present(navigationController, animated: true, completion: nil)
  }
}

extension MainCoordinator: MainControllerDelegate {
  
  func pushFavorites(controller: MainController) {
    guard let navController = controller.navigationController else { return }
    let favoritesCoordinator = FavoritesCoordinator(navigationController: navController)
    
    favoritesCoordinator.pushFavoriteList()
  }
  
  func pushDetailView(forCellViewModel cellViewModel: MediaCellViewModel,
                      controller: MainController) {
    guard let navController = controller.navigationController else { return }
    let detailCoordinator = DetailCoordinator(navigationController: navController)
    
    detailCoordinator.pushDetail(forCellViewModel: cellViewModel)
  }
}
