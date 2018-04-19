//
//  GameTableViewCell.swift
//  GamesTODO
//
//  Created by Soft Project on 4/19/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class GameTableViewCell: UITableViewCell {
  
  // MARK: - Outlets
  @IBOutlet weak private var posterImageView: UIImageView!
  @IBOutlet weak private var titleLabel: UILabel!
  @IBOutlet weak private var genreLabel: UILabel!
  
  // MARK: - Properties
  var poster: UIImage? {
    didSet {
      posterImageView.image = poster
    }
  }
  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
  var genre: String? {
    didSet {
      isHidden = genre == nil
      genreLabel.text = genre
    }
  }
  
  // MARK: - Lifeccycle events
  override func awakeFromNib() {
    super.awakeFromNib()
    posterImageView.layer.borderWidth = 1
    posterImageView.layer.borderColor = UIColor.AppColors.dark.cgColor
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    posterImageView.layer.cornerRadius = posterImageView.frame.height / 2
  }
}
