//
//  Media.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Media: Object, Codable {

  dynamic var id: Int
  dynamic var title: String
  dynamic var artwork: String
  dynamic var genre: String
  dynamic var price: Double
  dynamic var longDescription: String
  
  private enum CodingKeys: String, CodingKey {
    case id = "trackId"
    case title = "trackName"
    case artwork = "artworkUrl100"
    case genre = "primaryGenreName"
    case price = "trackPrice"
    case longDescription
  }
}
