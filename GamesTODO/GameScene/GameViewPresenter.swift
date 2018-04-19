//
//  GameViewPresenter.swift
//  GamesTODO
//
//  Created by Soft Project on 4/16/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
import CoreData

protocol GameView: class {
  func error(message: String)
  func succesAdded(game: GameItem)
  func succesUpdated(game: GameItem)
}

final class GameViewPresenter {
  
  // MARK: - Properties
  weak var presenter: GameView?
  private weak var managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

  // MARK: - Initializers
  init(presenter: GameView) {
    self.presenter = presenter
  }

  // MARK: - Public methods
  func save(game: GameItem) {

    guard let managedContext = self.managedContext else {
      presenter?.error(message: "Managed context does not set properly")
      return
    }
    
    let entity = NSEntityDescription.entity(forEntityName: "Game", in: managedContext).unsafelyUnwrapped
    
    let gameToSave = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
    
    setCoredata(model: gameToSave, from: game)
    if let imageToSave = game.poster {
      ImageCachingService.sharedInstance.saveImage(image: imageToSave, key: game.imageKey)
    }
    do {
      try managedContext.save()
      presenter?.succesAdded(game: game)
    } catch let error {
      presenter?.error(message: error.localizedDescription)
    }
  }
  
  func update(game: GameItem, with newData: GameItem) {
    let gamesFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
    gamesFetchRequest.predicate = NSPredicate(format: "title = %@", game.title)
    do {
      let games = try managedContext?.fetch(gamesFetchRequest)
      guard let gameToUpdate = games?.first else {
        presenter?.error(message: "Game does not exists")
        return
      }
      setCoredata(model: gameToUpdate, from: newData)
      try? ImageCachingService.sharedInstance.delete(game.imageKey)
      if let imageToSave = newData.poster {
        ImageCachingService.sharedInstance.saveImage(image: imageToSave, key: newData.imageKey)
      }
      try managedContext?.save()
      presenter?.succesUpdated(game: newData)
    } catch let error as NSError {
      presenter?.error(message: error.localizedDescription)
    }
  }
  
  // MARK: - Private
  private func setCoredata(model: NSManagedObject, from game: GameItem) {
    model.setValue(game.title, forKeyPath: "title")
    model.setValue(game.fullDescription, forKeyPath: "fullDescription")
    model.setValue(game.genre, forKeyPath: "genre")
    model.setValue(game.releaseDate, forKeyPath: "releaseDate")
    model.setValue(game.isFinished, forKeyPath: "isFinished")
  }
}
