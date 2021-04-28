//
//  MediaCellViewModel.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Foundation

class MediaCellViewModel {
  
  var artwork: String { return media?.artwork ?? "" }
  var title: String { return media?.title ?? "No title available" }
  var genre: String { return media?.genre ?? "" }
  var price: String { return "$\(media?.price ?? 0.0)" }
  var description: String { return media?.longDescription ?? "No description available" }
  
  private var media: Media?
  
  init(media: Media) {
    self.media = media
  }
}
