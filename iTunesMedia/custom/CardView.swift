//
//  CardView.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 4/28/21.
//  Copyright © 2021 dummy. All rights reserved.
//

import UIKit

class CardView: UIView {
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    initRoundedShadowCorners()
  }
  
  private func initRoundedShadowCorners() {
    layer.cornerRadius = 8.0
    layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    layer.shadowColor = UIColor.lightGray.cgColor
    layer.shadowRadius = 1.0
    layer.shadowOpacity = 1
    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }
}
