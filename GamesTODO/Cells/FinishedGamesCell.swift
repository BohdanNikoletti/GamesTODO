//
//  FinishedGamesCell.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 4/12/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class FinishedGamesCell: UITableViewCell {
  
  // MARK: Outlets
  @IBOutlet weak private var collectionView: UICollectionView!
//  var needUpdate: Bool = true {
//    didSet {
//      collectionView.re
//    }
//  }
  var selectedIndexPath: IndexPath? {
    return collectionView.indexPathsForSelectedItems?.first
  }
  
  func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
    
    collectionView.delegate = dataSourceDelegate
    collectionView.dataSource = dataSourceDelegate
//        collectionView.tag = row
//        collectionView.setContentOffset(collectionView.contentOffset, animated: false) // Stops collection view if it was scrolling.
    collectionView.reloadData()
  }
  
  var collectionViewOffset: CGFloat {
    set { collectionView.contentOffset.x = newValue }
    get { return collectionView.contentOffset.x }
  }

}
