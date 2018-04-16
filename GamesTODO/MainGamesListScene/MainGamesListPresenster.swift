//
//  ViewPresenter.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 4/13/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import Foundation

protocol MainGamesListView {
  func error(message: String)
  func show(games: [GameItem])
  func show(game: GameItem)
}

final class MainGamesListPresenster {
  
  var presenter: MainGamesListView!
  
  init(presenter: MainGamesListView) {
    self.presenter = presenter
  }
  
  func getGames() {
  }

}
