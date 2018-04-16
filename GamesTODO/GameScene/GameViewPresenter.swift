//
//  GameViewPresenter.swift
//  GamesTODO
//
//  Created by Soft Project on 4/16/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
import CoreData

protocol GameView {
  func error(message: String)
  func succesAdded(game: GameItem)
}

final class GameViewPresenter {
  
  var presenter: GameView!
  
  init(presenter: GameView) {
    self.presenter = presenter
  }
  
  func save(game: GameItem) {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "Game",
                                 in: managedContext).unsafelyUnwrapped
    
    let gameToSave = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    gameToSave.setValue(game.title, forKeyPath: "title")
    if let imageToSave = game.poster {
      ImageCachingService.sharedInstance.saveImage(image: imageToSave, key: game.imageKey)
    }
    do {
      try managedContext.save()
      presenter.succesAdded(game: game)
//      people.append(person)
    } catch let error {
      presenter.error(message: error.localizedDescription)
    }
  }
}
