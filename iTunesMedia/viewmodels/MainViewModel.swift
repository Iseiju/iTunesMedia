//
//  MainViewModel.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Alamofire
import Foundation

class MainViewModel {
  
  func getMedia() {
    let url = "https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp;all"
    
    AF.request(url, method: .get).responseDecodable(of: PagedResponse.self) { response in
      switch response.result {
      case .success(let results):
        print(results.count)
      case .failure(let error as NSError):
        print(error.localizedDescription)
      }
    }
  }
}
