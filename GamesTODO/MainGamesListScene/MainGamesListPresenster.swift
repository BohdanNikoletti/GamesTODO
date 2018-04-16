//
//  ViewPresenter.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 4/13/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
import CoreData

protocol MainGamesListView: class {
  func error(message: String)
  func show(games: [GameItem])
  func show(game: GameItem)
}

final class MainGamesListPresenster {
  
  weak var presenter: MainGamesListView!
  
  init(presenter: MainGamesListView) {
    self.presenter = presenter
  }
  
  func getGames() {
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext =
      appDelegate.persistentContainer.viewContext
    
    let fetchRequest =
      NSFetchRequest<NSManagedObject>(entityName: "Game")
    
    do {
      let games = try managedContext.fetch(fetchRequest)
      presenter.show(games: games.map { GameItem($0) })
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }

}
