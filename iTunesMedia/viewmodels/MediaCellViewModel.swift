//
//  MediaCellViewModel.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Foundation

class MediaCellViewModel {
  
  private var media: Media?
  
  var artwork: String { return media?.artwork ?? "" }
  
  var title: String {
    return (media?.title != nil ? media?.title : media?.collectionTitle) ?? "No title available"
  }
  
  var genre: String { return media?.genre ?? "" }
  
  var price: String {
    let mainPrice = "$\(String(media?.price ?? 0.0))"
    let collectionPrice = "$\(String(media?.collectionPrice ?? 00))"
    
    return media?.price != nil ? mainPrice : collectionPrice
  }
  
  var description: String { return media?.longDescription ?? "No description available." }
  
  init(media: Media) {
    self.media = media
  }
}
