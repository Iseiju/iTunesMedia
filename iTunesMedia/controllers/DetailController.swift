//
//  DetailController.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 9/8/20.
//  Copyright © 2020 dummy. All rights reserved.
//

import Kingfisher
import UIKit

class DetailController: UIViewController {
  
  var viewModel: DetailViewModel?
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var artworkImageView: UIImageView!
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initViews()
  }
  
  private func initViews() {
    let url = URL(string: self.viewModel?.artwork ?? "")
    
    backgroundImageView.kf.indicatorType = .activity
    artworkImageView.kf.indicatorType = .activity
    
    backgroundImageView
      .kf
      .setImage(with: url,
                placeholder: R.image.icHplaceholder(),
                options: [.transition(.fade(0.2))])
    
    artworkImageView
      .kf
      .setImage(with: url,
                placeholder: R.image.icVplaceholder(),
                options: [.transition(.fade(0.2))])
    
    titleLabel.text = viewModel?.title
    genreLabel.text = viewModel?.genre
    priceLabel.text = viewModel?.price
    descriptionLabel.text = viewModel?.description
  }
}
