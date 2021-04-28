//
//  FavoriteViewModel.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 4/28/21.
//  Copyright © 2021 dummy. All rights reserved.
//

import Foundation
import RealmSwift
import RxCocoa
import RxSwift

class FavoriteViewModel {

  private let disposeBag = DisposeBag()
  
  private let mediaRelay = BehaviorRelay<[Media]>(value: [])
  
  func getFavorites() {
    let mediaList = Media.queryAll(),
        favorites = Favorite.queryAll()
    
    var filteredMedia: [Media] = []
    
    favorites.forEach { favorite in
      filteredMedia.append(contentsOf: mediaList.filter("id = %@", favorite.id))
    }
    
    mediaRelay.accept(filteredMedia)
  }
  
  func removeFromFavorites(_ cellViewModel: MediaCellViewModel) {
    let id = cellViewModel.id
    let favoriteToRemove = Favorite.queryAll().filter("id = %@", id)
    
    Favorite.delete(favoriteToRemove)
    
    getFavorites()
  }
  
  func cellViewModels() -> BehaviorRelay<[MediaCellViewModel]> {
    let cellViewModels = BehaviorRelay<[MediaCellViewModel]>(value: [])
    
    mediaRelay.subscribe(onNext: { media in
      cellViewModels.accept(media.map { media in
        return MediaCellViewModel(media, true)
      })
    }).disposed(by: disposeBag)
    
    return cellViewModels
  }
}
