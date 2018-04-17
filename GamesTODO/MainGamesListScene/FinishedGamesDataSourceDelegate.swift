//
//  FinishedGamesDataSourceDelegate.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 15.04.2018.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class FinishedGamesDataSourceDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
  
  // MARK: - Properties
  var games: [GameItem] = []
  
  // MARK: - UICollectionViewDelegate & UICollectionViewDataSource methods
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
  }
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return games.isEmpty ? 1 : 2
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 { // Empty sections
      return games.isEmpty ? 1 : 0
    }
    return games.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 { // Empty section case
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyFinishedGameCell", for: indexPath)
      cell.layer.cornerRadius = 5
      return cell
    }
    guard let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "finishedGameCell",
                           for: indexPath) as? FinishedGameCell else {
                            fatalError("Can not cast finishedGameCell to FinishedGameCell")
    }
    let game = games[indexPath.row]
    cell.title = game.title
    cell.posterImage = game.poster
    return cell
  }
}
