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
  let fullDescription: String?
  let genre: String
  var releaseDate: Date?
  let isFinished: Bool
  private var image: UIImage?
  var poster: UIImage? {
    get {
      return ImageCachingService.sharedInstance.getImage(key: imageKey) ?? image
    }
    set {
      image = poster
    }
  }
  
  var imageKey: String {
    return "\(title)\(isFinished)"
  }
  
  var releaseDateString: String {
    set {
      releaseDate = DateFormatter.base.date(from: releaseDateString)
    }
    get {
      guard let releaseDate = self.releaseDate else {
        return "TBA"
      }
      return DateFormatter.base.string(from: releaseDate)
    }
  }
  
  var searchContent: String {
    return title+(fullDescription ?? "")+genre+releaseDateString
  }
  
  init(title: String, fullDescription: String, genre: String,
       releaseDate: Date?, poster: UIImage?, isFinished: Bool = false) {
    self.title = title
    self.fullDescription = fullDescription
    self.genre = genre
    self.releaseDate = releaseDate
    self.image = poster
    self.isFinished = isFinished
  }
  
  init( _ coreDataModel: NSManagedObject) {
    self.title = (coreDataModel.value(forKey: "title") as? String) ?? ""
    self.fullDescription = (coreDataModel.value(forKey: "fullDescription") as? String) ?? ""
    self.genre = (coreDataModel.value(forKey: "genre") as? String) ?? ""
    self.releaseDate = (coreDataModel.value(forKey: "releaseDate") as? Date) ?? Date()
    self.isFinished = (coreDataModel.value(forKey: "isFinished") as? Bool) ?? false

  }
  
}
