//
//  Favorite.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 4/28/21.
//  Copyright © 2021 dummy. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Favorite: Object {
  
  dynamic var id: Int = 0
  
  override class func primaryKey() -> String? {
    return "id"
  }
}
