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
  
  // MARK: - Properties
  weak var presenter: MainGamesListView!
  weak var managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
  
  // MARK: - Initializers
  init(presenter: MainGamesListView) {
    self.presenter = presenter
  }
  
  // MARK: - Public methods
  func getGames() {

    let gamesFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
    gamesFetchRequest.predicate = nil
    do {
      guard let games = try managedContext?.fetch(gamesFetchRequest) else {
        presenter.error(message: "There is no local games")
        return
      }
      presenter.show(games: games.map { GameItem($0) })
    } catch let error as NSError {
      presenter.error(message: error.localizedDescription)
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }

  func delete(_ game: GameItem) {
    let gamesFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
    gamesFetchRequest.predicate = NSPredicate(format: "title = %@", game.title)
   
    do {
      let games = try managedContext?.fetch(gamesFetchRequest)
      guard let gameToDelete = games?.first else {
        presenter.error(message: "Game does not exists")
        return
      }
      managedContext?.delete(gameToDelete)
      try managedContext?.save()
    } catch let error as NSError {
      presenter.error(message: error.localizedDescription)
    }
  }
}
