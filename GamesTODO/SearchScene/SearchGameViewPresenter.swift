//
//  SearchPresenter.swift
//  GamesTODO
//
//  Created by Soft Project on 4/17/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import CoreData
import UIKit

protocol SearchGameView: class {
  func error(message: String)
  func show(games: [GameItem])
}

final class SearchGameViewPresenter {
  
  // MARK: - Properties
  weak var presenter: SearchGameView!
  
  // MARK: - Initializers
  init(presenter: SearchGameView) {
    self.presenter = presenter
  }
  
  // MARK: - Public methods
  func getGames() {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let gamesFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
    do {
      let games = try managedContext.fetch(gamesFetchRequest)
      presenter.show(games: games.map { GameItem($0) })
    } catch let error as NSError {
      presenter.error(message: error.localizedDescription)
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
}
