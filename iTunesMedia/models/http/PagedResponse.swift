//
//  PagedResponse.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Foundation

struct PagedResponse: Codable {
  
  var count: Int
  var results: [Media]
  
  private enum CodingKeys: String, CodingKey {
    case count = "resultCount"
    case results
  }
}
