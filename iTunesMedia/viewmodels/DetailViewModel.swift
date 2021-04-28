//
//  DetailViewModel.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Foundation

class DetailViewModel {
  
  var id: Int { return cellViewModel?.id ?? 0 }
  
  var isFavorite: Bool { return cellViewModel?.isFavorite ?? false }
  
  var artwork: String { return cellViewModel?.artwork ?? "" }
  var title: String { return cellViewModel?.title ?? "" }
  var genre: String { return cellViewModel?.genre ?? "" }
  var price: String { return cellViewModel?.price ?? "" }
  var description: String { return cellViewModel?.description ?? "" }
  
  private var cellViewModel: MediaCellViewModel?
  
  init(cellViewModel: MediaCellViewModel) {
    self.cellViewModel = cellViewModel
  }
  
  func addToFavorites(completion: @escaping (_ wasAdded: Bool) -> Void) {
    let realmFavorites = Favorite.queryAll()
    
    if realmFavorites.contains(where: { $0.id == id }) {
      let removeFavorite = realmFavorites.filter("id = %@", id)
      
      Favorite.delete(removeFavorite)
      completion(false)
    } else {
      let favorite = Favorite()
      favorite.id = id

      Favorite.save(favorite)
      completion(true)
    }
  }
}
