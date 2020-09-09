//
//  AppDelegate.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    migration()
    
    return true
  }
  
  private func migration() {
    let config = Realm.Configuration(
      schemaVersion: 4,

      migrationBlock: { migration, oldSchemaVersion in
        if (oldSchemaVersion < 1) { }
      })
    
    Realm.Configuration.defaultConfiguration = config
    
    do {
      let _ = try Realm()
    } catch  {
      print(error.localizedDescription)
    }
  }
}

