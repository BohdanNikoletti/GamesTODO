//
//  ViewPresenter.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 4/13/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
import CoreData

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
    //1
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext =
      appDelegate.persistentContainer.viewContext
    
    //2
    let fetchRequest =
      NSFetchRequest<NSManagedObject>(entityName: "Person")
    
    //3
    do {
      let games = try managedContext.fetch(fetchRequest)
      presenter.show(games: games.map { GameItem($0) })
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }

}
