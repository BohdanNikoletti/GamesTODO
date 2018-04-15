//
//  ViewPresenter.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 4/13/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import Foundation

protocol MainGamesListPresensterProtocol {
  func error(message: String)
  func show(games: [Game])
  func show(game: Game)
}

class MainGamesListPresenster: NSObject {
  var presenter: MainGamesListPresensterProtocol!
  
  init(presenter: MainGamesListPresensterProtocol) {
    self.presenter = presenter;
  }
  
  func getGames(){
  }

}
