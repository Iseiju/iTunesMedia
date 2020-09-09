//
//  DetailViewModel.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Foundation

class DetailViewModel {
  
  private var cellViewModel: MediaCellViewModel?
  
  var artwork: String { return cellViewModel?.artwork ?? "" }
  var title: String { return cellViewModel?.title ?? "" }
  var genre: String { return cellViewModel?.genre ?? "" }
  var price: String { return cellViewModel?.price ?? "" }
  var description: String { return cellViewModel?.description ?? "" }
  
  init(cellViewModel: MediaCellViewModel) {
    self.cellViewModel = cellViewModel
  }
}
