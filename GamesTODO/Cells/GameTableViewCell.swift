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
  @IBOutlet weak private var titlelabel: UILabel!
  @IBOutlet weak private var genreLabel: UILabel!
  
  // MARK: - Properties
  var poster: UIImage? {
    didSet {
      posterImageView.image = poster
    }
  }
  var title: String? {
    didSet {
      titlelabel.text = title
    }
  }
  var genre: String? {
    didSet {
      genreLabel.text = genre
    }
  }
  
  // MARK: - Lifeccycle events
  override func awakeFromNib() {
    super.awakeFromNib()
    posterImageView.layer.cornerRadius = posterImageView.frame.height / 2
    posterImageView.layer.borderWidth = 1
    posterImageView.layer.borderColor = UIColor.AppColors.dark.cgColor
  }
  
//  override func setSelected(_ selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
//
//    // Configure the view for the selected state
//  }
//
}
