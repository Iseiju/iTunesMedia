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
  
  var artwork: String {
    return media?.artwork ?? ""
  }
  
  var title: String {
    return media?.title ?? "No title available"
  }
  
  var genre: String {
    return media?.genre ?? ""
  }
  
  var price: String {
    return media?.price != nil ? "$\(String(media?.price ?? 0.0))" : "No price available"
  }
  
  var description: String {
    return media?.longDescription ?? "No description available."
  }
  
  init(media: Media) {
    self.media = media
  }
}
