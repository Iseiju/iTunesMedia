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
  
  static func queryAll() -> Results<Favorite> {
    let realm = try! Realm()
    return realm.objects(Favorite.self)
  }
  
  static func save(_ favorite: Favorite) {
    do {
      let realm = try Realm()
      
      try realm.write {
        realm.add(favorite, update: .modified)
      }
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  static func delete(_ favorite: Results<Favorite>) {
    do {
      let realm = try Realm()
      
      try realm.write {
        realm.delete(favorite)
      }
    } catch let error {
      print(error.localizedDescription)
    }
  }
}
