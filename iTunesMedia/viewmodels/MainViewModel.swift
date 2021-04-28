//
//  MainViewModel.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class MainViewModel {
  
  private let realm = try! Realm()
  
  private let disposeBag = DisposeBag()
  
  private var listOfMedia: [Media] = []
  
  private let mediaRelay = BehaviorRelay<[Media]>(value: [])
  
  func getMedia(completion: @escaping (_ isSuccess: Bool, _ errorOrNil: NSError?) -> Void) {
    let url = "https://itunes.apple.com/search?term=star&country=au&media=movie"
    
    APIClient.shared.get(url: url, model: PagedResponse.self, completion: { response in
      switch response.result {
      case .success(let pagedResponse):
        let listOfMedia = pagedResponse.results
        
        try! self.realm.write {
          self.realm.add(listOfMedia)
        }
        
        self.listOfMedia = listOfMedia
        self.mediaRelay.accept(listOfMedia)

        completion(true, nil)
        
      case .failure(let error as NSError):
        let realmItems = self.realm.objects(Media.self)
        
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
  
  func filterMedia(query: String) {
    if query.isEmpty {
      mediaRelay.accept(listOfMedia)
    } else {
      let filtered = self.listOfMedia.filter { $0.title.lowercased().contains(query.lowercased()) }

      mediaRelay.accept(filtered)
    }
  }
  
  func cellViewModels() -> BehaviorRelay<[MediaCellViewModel]> {
    let cellViewModels = BehaviorRelay<[MediaCellViewModel]>(value: [])
    
    mediaRelay.subscribe(onNext: { media in
      cellViewModels.accept(media.map { return MediaCellViewModel(media: $0) })
    }).disposed(by: disposeBag)
    
    return cellViewModels
  }
}
