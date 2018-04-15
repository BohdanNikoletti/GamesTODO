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
  var games: [Game] = [ Game(title: "Title", description: "Description", genre: "Genre", releaseDate: Date(), poster: nil),
                        Game(title: "Title2", description: "Description2", genre: "Genre3", releaseDate: Date(), poster: nil)]
  
  // MARK: - UICollectionViewDelegate & UICollectionViewDataSource methods
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return games.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
