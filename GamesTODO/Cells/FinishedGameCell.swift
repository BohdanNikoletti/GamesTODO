//
//  FinishedGameCell.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 4/12/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class FinishedGameCell: UICollectionViewCell {
  
  // MARK: Outlets
  @IBOutlet weak private var nameLabel: UILabel!
  @IBOutlet weak private var posterImageView: UIImageView!
  
  // MARK: - Properties
  var title: String? {
    didSet {
      nameLabel.text = title
    }
  }
  var posterImage: UIImage? {
    didSet {
      posterImageView.image = posterImage ?? #imageLiteral(resourceName: "empty-image")
    }
  }
  
  // MARK: Lifecycle events
  override func awakeFromNib() {
    super.awakeFromNib()
    customize()
  }
  
  // MARK: Private methods
  private func customize() {
    layer.cornerRadius = 5.0
    layer.borderWidth = 1.0
    layer.borderColor = UIColor.clear.cgColor
    layer.masksToBounds = true
    
    layer.shadowColor = UIColor.lightGray.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2.0)
    layer.shadowRadius = 2.0
    layer.shadowOpacity = 1.0
    layer.masksToBounds = false
    layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
  }
}
