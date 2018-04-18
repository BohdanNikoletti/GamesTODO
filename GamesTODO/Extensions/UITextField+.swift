//
//  UITextField+.swift
//  GamesTODO
//
//  Created by Soft Project on 4/18/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
extension UITextField {
  func setBottomBorderStyle() {
    let border = CALayer()
    let borderHeight = CGFloat(2.0)
    border.borderColor = UIColor.darkGray.cgColor
    let yPos = self.frame.size.height - borderHeight
    let width = self.frame.size.width
    let height = self.frame.size.height
    border.frame = CGRect(x: 0, y: yPos, width: width, height: height)
    self.borderStyle = .none
    border.borderWidth = width
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
  }
}
