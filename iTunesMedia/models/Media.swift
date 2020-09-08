//
//  Media.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Foundation

struct Media: Codable {
  
  var title: String?
  var artwork: String
  var price: Double?
  var genre: String
  var description: String?
  
  private enum CodingKeys: String, CodingKey {
    case title = "trackName"
    case artwork = "artworkUrl100"
    case price = "trackPrice"
    case genre = "primaryGenreName"
    case description = "longDescription"
  }
}
