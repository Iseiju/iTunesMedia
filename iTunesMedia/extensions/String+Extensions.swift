//
//  String+Extensions.swift
//  iTunesMedia
//
//  Created by Kenneth James Uy on 4/28/21.
//  Copyright © 2021 dummy. All rights reserved.
//

import Foundation

private protocol StringExtensions {
  
  func htmlToString() -> String
}

extension String: StringExtensions {
  
  internal func htmlToAttributedString() -> NSAttributedString {
    guard let data = data(using: .utf8) else { return NSAttributedString() }
    do {
      return try NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html,
                                              .characterEncoding:String.Encoding.utf8.rawValue],
                                    documentAttributes: nil)
    } catch {
      return NSAttributedString()
    }
  }
  
  func htmlToString() -> String {
    return htmlToAttributedString().string
  }
}
