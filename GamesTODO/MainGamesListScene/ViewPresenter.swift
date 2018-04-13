//
//  ViewPresenter.swift
//  GamesTODO
//
//  Created by Soft Project on 4/13/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import Foundation

protocol MainGamesListPresensterProtocol {
  //  func presentFetchGames(hasil: Double)
  func error(message: String)
  func showGame(posts: [Game])
}

class MainGamesListPresenster: NSObject {
  var presenter: MainGamesListPresensterProtocol!
  
  init(presenter: MainGamesListPresensterProtocol) {
    self.presenter = presenter;
  }

  
  func getGames(){
  }

}
