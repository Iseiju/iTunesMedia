//
//  MainViewModel.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Alamofire
import Foundation
import RxCocoa
import RxSwift
import Unrealm

class MainViewModel {
  
  let realm = try! Realm()
  
  let disposeBag = DisposeBag()
  
  private let listOfMedia = BehaviorRelay<[Media]>(value: [])
  
  func getMedia(completion: @escaping (_ isEmpty: Bool, _ errorOrNil: NSError?) -> Void) {
    let url = "https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp;all"
    
    AF.request(url, method: .get).responseDecodable(of: PagedResponse.self) { response in
      switch response.result {
        
      case .success(let pagedResponse):
        let listOfMedia = pagedResponse.results
        
        try! self.realm.write {
          self.realm.add(listOfMedia)
        }
        
        self.listOfMedia.accept(listOfMedia)
        completion(pagedResponse.results.isEmpty, nil)
        
      case .failure(let error as NSError):
        let realmItems = self.realm.objects(Media.self)
        
        if realmItems.isEmpty {
          completion(true, error)
        } else {
          var listOfMedia: [Media] = []
          
          for media in listOfMedia {
            listOfMedia.append(media)
          }
          
          self.listOfMedia.accept(listOfMedia)
          completion(listOfMedia.isEmpty, nil)
        }
      }
    }
  }
  
  func cellViewModels() -> BehaviorRelay<[MediaCellViewModel]> {
    let cellViewModels = BehaviorRelay<[MediaCellViewModel]>(value: [])
    
    listOfMedia.subscribe(onNext: { media in
      cellViewModels.accept(media.map { return MediaCellViewModel(media: $0) })
    }).disposed(by: disposeBag)
    
    return cellViewModels
  }
}
