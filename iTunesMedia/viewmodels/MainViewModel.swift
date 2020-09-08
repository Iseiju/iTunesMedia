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

class MainViewModel {
  
  let disposeBag = DisposeBag()
  
  let listOfMedia = BehaviorRelay<[Media]>(value: [])
  
  func getMedia(completion: @escaping (_ isEmpty: Bool, _ errorOrNil: NSError?) -> Void) {
    let url = "https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp;all"
    
    AF.request(url, method: .get).responseDecodable(of: PagedResponse.self) { response in
      switch response.result {
        
      case .success(let pagedResponse):
        let listOfMedia = pagedResponse.results
        self.listOfMedia.accept(listOfMedia)
        print(pagedResponse.results.count)
        completion(pagedResponse.results.isEmpty, nil)
        
      case .failure(let error as NSError):
        completion(true, error)
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
