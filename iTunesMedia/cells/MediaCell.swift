//
//  MediaCell.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Kingfisher
import UIKit

class MediaCell: UITableViewCell {
  
  var cellViewModel: MediaCellViewModel?

  @IBOutlet weak var artworkImageView: UIImageView!
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.selectionStyle = .none
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func initCell(_ cellViewModel: MediaCellViewModel) {
    self.cellViewModel = cellViewModel
    
    let url = URL(string: self.cellViewModel?.artwork ?? "")
    
    artworkImageView.kf.indicatorType = .activity
    artworkImageView.kf.setImage(with: url,
                                 placeholder: R.image.icPlaceholder(),
                                 options: [.transition(.fade(0.2))])
    
    self.titleLabel.text = self.cellViewModel?.title
    self.genreLabel.text = self.cellViewModel?.genre
    self.priceLabel.text = self.cellViewModel?.price
  }
}
