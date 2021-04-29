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
  
  // MARK: - Get Favorite list in Persistence layer
  func getFavorites() {
    let mediaList = RealmClient.shared.queryAll(Media.self)
    let favorites = RealmClient.shared.queryAll(Favorite.self)
    
    var filteredMedia: [Media] = []
    
    favorites.forEach { favorite in
      filteredMedia.append(contentsOf: mediaList.filter("id = %@", favorite.id))
    }
    
    mediaRelay.accept(filteredMedia)
  }
  
  // MARK: - Functions
  func removeFromFavorites(_ cellViewModel: MediaCellViewModel) {
    let id = cellViewModel.id
    let favoriteToRemove = RealmClient
      .shared
      .queryAll(Favorite.self).filter("id = %@", id)
      .first ?? Favorite()

    RealmClient.shared.delete(favoriteToRemove)
    
    getFavorites()
  }
  
  // MARK: - CellViewModel mapping and subscribing
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
