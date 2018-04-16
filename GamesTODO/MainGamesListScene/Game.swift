//
//  Game.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 15/04/2018.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
import CoreData

struct GameItem {
  let title: String
  let fullDescription: String
  let genre: String
  let releaseDate: Date?
//  let isFinished: Bool

  var poster: UIImage? {
    return ImageCachingService.sharedInstance.getImage(key: "")
  }
  
  var imageKey: String {
    return "\(title)\(releaseDateString)"
  }
  
  var releaseDateString: String {
    guard let releaseDate = self.releaseDate else {
      return "TBA"
    }
    return DateFormatter.base.string(from: releaseDate)
    
  }
  
  var searchContent: String {
    return title+fullDescription+genre+releaseDateString
  }
  
  init (title: String, fullDescription: String, genre: String, releaseDate: Date, poster: UIImage?) {
    self.title = title
    self.fullDescription = fullDescription
    self.genre = genre
    self.releaseDate = releaseDate
//    self.poster = poster
  }
  init( _ coreDataModel: NSManagedObject) {
    self.title = (coreDataModel.value(forKey: "title") as? String) ?? ""
    self.fullDescription = (coreDataModel.value(forKey: "fullDescription") as? String) ?? ""
    self.genre = (coreDataModel.value(forKey: "genre") as? String) ?? ""
    self.releaseDate = (coreDataModel.value(forKey: "releaseDate") as? Date) ?? Date()

  }

}
