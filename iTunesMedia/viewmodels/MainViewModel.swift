//
//  MainViewModel.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Foundation
import RealmSwift
import RxCocoa
import RxSwift

class MainViewModel {
  
  private let disposeBag = DisposeBag()
  
  private var listOfMedia: [Media] = []
  
  private let mediaRelay = BehaviorRelay<[Media]>(value: [])
  
  // MARK: - Main API request
  func getMedia(completion: @escaping (_ isSuccess: Bool, _ errorOrNil: NSError?) -> Void) {
    let url = "https://itunes.apple.com/search?term=star&country=au&media=movie"
    
    APIClient.shared.get(url: url, model: PagedResponse.self, completion: { response in
      switch response.result {
      case .success(let pagedResponse):
        let listOfMedia = pagedResponse.results
        
        RealmClient.shared.saveAll(listOfMedia)
        
        self.listOfMedia = listOfMedia
        self.mediaRelay.accept(listOfMedia)

        completion(true, nil)
        
      case .failure(let error as NSError):
        let realmItems = RealmClient.shared.queryAll(Media.self)
        
        if realmItems.isEmpty {
          completion(false, error)
        } else {
          var listOfMedia: [Media] = []
          
          for items in realmItems {
            listOfMedia.append(items)
          }
          
          self.listOfMedia = listOfMedia
          self.mediaRelay.accept(listOfMedia)
          
          completion(true, nil)
        }
      }
    })
  }
  
  // MARK: - Functions
  func filterMedia(query: String) {
    if query.isEmpty {
      mediaRelay.accept(listOfMedia)
    } else {
      let filtered = self.listOfMedia.filter { $0.title.lowercased().contains(query.lowercased()) }

      mediaRelay.accept(filtered)
    }
  }
  
  func addToFavorites(_ cellViewModel: MediaCellViewModel) {
    let id = cellViewModel.id
    let realmFavorites = RealmClient.shared.queryAll(Favorite.self)
    
    if realmFavorites.contains(where: { $0.id == id }) {
      let removeFavorite = realmFavorites.filter("id = %@", id).first ?? Favorite()
      RealmClient.shared.delete(removeFavorite)
    } else {
      let favorite = Favorite()
      favorite.id = id

      RealmClient.shared.save(favorite)
    }
    
    mediaRelay.accept(self.mediaRelay.value)
  }
  
  // MARK: - CellViewModel mapping and subscribing
  func cellViewModels() -> BehaviorRelay<[MediaCellViewModel]> {
    let cellViewModels = BehaviorRelay<[MediaCellViewModel]>(value: [])
    
    mediaRelay.subscribe(onNext: { media in
      cellViewModels.accept(media.map { media in
        let isFavorite = RealmClient.shared.queryAll(Favorite.self).contains(where: { $0.id == media.id })
        return MediaCellViewModel(media, isFavorite)
      })
    }).disposed(by: disposeBag)
    
    return cellViewModels
  }
}
