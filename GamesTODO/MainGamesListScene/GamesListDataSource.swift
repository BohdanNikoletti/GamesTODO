//
//  GamesListDataSource.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 15.04.2018.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class GamesListDataSource: NSObject, UITableViewDataSource {
  
  private let finishedGamesSourceDelegator = FinishedGamesDataSourceDelegate()
//  var games: [GameItem] = [] {
//    didSet {
//      let finishedGames = games.filter { $0.isFinished }
//      todoGames = games.filter { !$0.isFinished }
//      finishedGamesSourceDelegator.games = finishedGames
//    }
//  }
  var finishedGames: [GameItem] = [] {
    didSet {
      finishedGamesSourceDelegator.games = finishedGames
    }
  }
  var todoGames: [GameItem] = []
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : (todoGames.isEmpty ? 1 : todoGames.count)
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return indexPath.section != 0 && !todoGames.isEmpty
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let cell = tableView
        .dequeueReusableCell(withIdentifier: "finishedGamesCell",
                             for: indexPath) as? FinishedGamesCell else {
                              fatalError("can not cast finishedGamesCell to FinishedGamesCell")
      }
      cell.setCollectionViewDataSourceDelegate(finishedGamesSourceDelegator, forRow: indexPath.row)
      cell.selectionStyle = .none
      return cell
    } else if !todoGames.isEmpty {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as? GameTableViewCell else {
        fatalError("Can not cast gameCell to GameTableViewCell")
      }
      let game = todoGames[indexPath.row]
      cell.title = game.title
      cell.genre = game.genre
      cell.poster = game.poster
      return cell
    } else {
      let emptyCell = tableView.dequeueReusableCell(withIdentifier: "emptyGamesCell")
      return emptyCell.unsafelyUnwrapped
    }
  }
}
