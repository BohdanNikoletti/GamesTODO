//
//  DateFormatter+.swift
//  GamesTODO
//
//  Created by Soft Project on 4/16/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import Foundation
extension DateFormatter {
  static let base: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter
  }()
  
}
