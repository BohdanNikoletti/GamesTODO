//
//  GamesListDataSource.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 15.04.2018.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
//
//final class GamesListDataSource: NSObject, UITableViewDataSource {
//  
//  // MARK: - Properties
//  var games: [GameItem] = [GameItem(title: "Title", fullDescription: "Description", genre: "Genre", releaseDate: Date(), poster: nil)]
//  private let delegatTest = FinishedGamesDataSourceDelegate()
//  
//  // MARK: - UITableViewDataSource methdos
//  func tableView(_ tableView: UITableView,
//                 numberOfRowsInSection section: Int) -> Int {
//    return section == 0 ? 1 : games.count
//  }
//  
//  func numberOfSections(in tableView: UITableView) -> Int {
//    return 2
//  }
//  
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    if indexPath.section == 0 {
//      guard let cell = tableView
//        .dequeueReusableCell(withIdentifier: "finishedGamesCell",
//                             for: indexPath) as? FinishedGamesCell else {
//                              fatalError("can not cast finishedGamesCell to FinishedGamesCell")
//      }
//      cell.setCollectionViewDataSourceDelegate(delegatTest, forRow: indexPath.row)
//      cell.selectionStyle = .none
//      return cell
//    } else {
//      var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//      if cell == nil {
//        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
//      }
//      cell?.textLabel?.text = games[indexPath.row].title
//      cell?.detailTextLabel?.text = games[indexPath.row].genre
//      cell?.imageView?.image = games[indexPath.row].poster ?? #imageLiteral(resourceName: "empty-image")
//      cell?.accessoryType = .disclosureIndicator
//      return cell.unsafelyUnwrapped
//    }
//  }
//}
