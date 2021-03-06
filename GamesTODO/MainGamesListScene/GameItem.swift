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
  
  // MARK: - Propeteis
  let title: String
  let fullDescription: String?
  let genre: String?
  let releaseDate: Date?
  let isFinished: Bool
  private var image: UIImage?
  
  // MARK: - Computed variables
  var poster: UIImage? {
    return ImageCachingService.sharedInstance.getImage(key: imageKey) ?? image
  }
  
  var imageKey: String {
    return "\(title)\(isFinished)"
  }
  
  var releaseDateString: String {
    guard let releaseDate = self.releaseDate else {
      return "TBA"
    }
    return DateFormatter.base.string(from: releaseDate)
  }
  
  var searchContent: String {
    let descriptionString = fullDescription?.trimmingCharacters(in: .whitespaces) ?? ""
    let genreString = genre ?? ""
    let finishedString = isFinished ? "finished" : ""
    return "\(title)\(descriptionString)\(genreString)\(releaseDateString)\(finishedString)"
  }
  
  // MARK: - Initializers
  init(title: String, fullDescription: String, genre: String?,
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
    self.releaseDate = (coreDataModel.value(forKey: "releaseDate") as? Date)
    self.isFinished = (coreDataModel.value(forKey: "isFinished") as? Bool) ?? false
  }
  
}
