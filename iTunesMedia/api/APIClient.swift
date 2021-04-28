//
//  APIClient.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 4/28/21.
//  Copyright © 2021 dummy. All rights reserved.
//

import Alamofire
import Foundation

class APIClient {
  
  static var shared: APIClient = { return APIClient() }()
  
  func get<T: Codable>(url: String,
                       model: T.Type,
                       completion: @escaping (_ response: DataResponse<T, AFError>) -> Void) {
    AF.request(url, method: .get).responseDecodable(of: model, completionHandler: completion)
  }
}
