//
//  GameSearchTableViewCell.swift
//  GamesTODO
//
//  Created by Soft Project on 4/19/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class GameSearchTableViewCell: UITableViewCell {
  // MARK: - Outlets
  @IBOutlet weak private var titleLabel: UILabel!
  @IBOutlet weak private var genreLabel: UILabel!
  @IBOutlet weak private var releaseDateLabel: UILabel!
  @IBOutlet weak private var posterImageView: UIImageView!
  @IBOutlet weak private var posterCover: UIView!

  // MARK: - Properties
  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
  
  var subTitle: String? {
    didSet {
      genreLabel.text = subTitle
    }
  }
  var bottomTitle: String? {
    didSet {
      releaseDateLabel.text = bottomTitle
    }
  }
  var backgroundImage: UIImage? {
    didSet {
      posterImageView.image = backgroundImage
    }
  }
  
  // MARK: - Lifecycle events
  override func awakeFromNib() {
    super.awakeFromNib()
    posterImageView.layer.cornerRadius = 5
    posterCover.layer.cornerRadius = 5
    posterImageView.clipsToBounds = true
  }

}
