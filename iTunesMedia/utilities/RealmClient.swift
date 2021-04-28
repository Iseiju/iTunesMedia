//
//  RealmClient.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 4/29/21.
//  Copyright © 2021 dummy. All rights reserved.
//

import Foundation
import RealmSwift

class RealmClient {
  
  static var shared: RealmClient = { return RealmClient() }()
  
  func queryAll<T: Object>(_ object: T.Type) -> Results<T> {
    let realm = try! Realm()
    return realm.objects(object)
  }
  
  func save(_ object: Object) {
    do {
      let realm = try Realm()
      
      try realm.write {
        realm.add(object, update: .modified)
      }
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func saveAll(_ objects: [Object]) {
    do {
      let realm = try Realm()
      
      try realm.write {
        realm.add(objects, update: .modified)
      }
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func delete(_ object: Object) {
    do {
      let realm = try Realm()
      
      try realm.write {
        realm.delete(object)
      }
    } catch let error {
      print(error.localizedDescription)
    }
  }
}
