//
//  ImageCachingService.swift
//  GamesTODO
//
//  Created by Soft Project on 4/16/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class ImageCachingService {
  
  static let sharedInstance = ImageCachingService()
  
  private init() { }
  
  private func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func saveImage(image: UIImage, key: String) {
    if let data = UIImagePNGRepresentation(image) {
      let filename = getDocumentsDirectory().appendingPathComponent("\(key).png")
      try? data.write(to: filename)
    }
  }
  
  func getImage(key: String) -> UIImage? {
    let fileManager = FileManager.default
    let filename = getDocumentsDirectory().appendingPathComponent("\(key).png")
    if fileManager.fileExists(atPath: filename.path) {
      return UIImage(contentsOfFile: filename.path)
    }
    return nil
  }
  
  func refresh() {
    let path = getDocumentsDirectory().path
    guard let items = try? FileManager.default.contentsOfDirectory(atPath: path) else { return }
    
    for item in items {
      if !item.contains(".png") { continue }
      let completePath = path.appending("/").appending(item)
      try? FileManager.default.removeItem(atPath: completePath)
    }
  }
}
