//
//  ViewController.swift
//  GamesTODO
//
//  Created by Soft Project on 4/12/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

struct Game {
  let title: String
  let description: String
  let genre: String
  let releaseDate: Date
  let poster: UIImage?
}

final class TableViewDelegate: NSObject, UITableViewDelegate {
  var games: [Game] = []
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return indexPath.section == 0 ? 100 : UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.01
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.textAlignment = .center
    //    label.textColor = UIColor.AppColors.darkSkyBlue
    label.adjustsFontSizeToFitWidth = true
    label.font = UIFont(name: "HelveticaNeue", size: 16.0)
    label.text = "Test"
    label.backgroundColor = #colorLiteral(red: 0.8820130229, green: 0.9472284913, blue: 0.9974038005, alpha: 1)
    return label
  }
}

final class FinishedGamesDataSourceDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "finishedGameCell",
                           for: indexPath) as? FinishedGameCell else {
                            fatalError("Can not cast collectionViewItem to FinishedGameCell")
    }
    return cell
  }
}
final class TableViewDataSource: NSObject, UITableViewDataSource {
  var games: [Game] = [ Game(title: "Test", description: "Test", genre: "Genre", releaseDate: Date(), poster: nil)]
  var delegatTest = FinishedGamesDataSourceDelegate()
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : games.count
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let cell = tableView
        .dequeueReusableCell(withIdentifier: "finishedGamesCell",
                             for: indexPath) as? FinishedGamesCell else {
                              fatalError("can not cast scheduleSectionCell to FinishedGamesCell")
      }
      cell.setCollectionViewDataSourceDelegate(delegatTest, forRow: indexPath.row)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
      cell.textLabel?.text = games[indexPath.row].title
      return cell
    }
  }
}

final class ViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak private var contentTable: UITableView!
  
  // MARK: - Properties
  private var games: [Game] = [ Game(title: "Test", description: "Test", genre: "Genre", releaseDate: Date(), poster: nil)]
  let delegatTest = FinishedGamesDataSourceDelegate()
  private let adapter = TableViewDataSource()
  // MARK: - Life cycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    contentTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    contentTable.delegate = TableViewDelegate()
    contentTable.dataSource = adapter//TableViewDataSource()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK: UITableViewDelegate extension
//extension ViewController: UITableViewDelegate {
//
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 200
//  }
//
//  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//    return 0.01
//  }
//
//  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let label = UILabel()
//    label.textAlignment = .center
//    //    label.textColor = UIColor.AppColors.darkSkyBlue
//    label.adjustsFontSizeToFitWidth = true
//    label.font = UIFont(name: "HelveticaNeue", size: 16.0)
//    label.text = "Test"
//    label.backgroundColor = #colorLiteral(red: 0.8820130229, green: 0.9472284913, blue: 0.9974038005, alpha: 1)
//    return label
//  }
//}

// MARK: UICollectionViewDelegate extension
//extension ViewController: UICollectionViewDelegate {
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
//  }
//}

// MARK: UITableViewDataSource extension
extension ViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : games.count
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let cell = tableView
        .dequeueReusableCell(withIdentifier: "finishedGamesCell",
                             for: indexPath) as? FinishedGamesCell else {
                              fatalError("can not cast scheduleSectionCell to FinishedGamesCell")
      }
      cell.setCollectionViewDataSourceDelegate(delegatTest, forRow: indexPath.row)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
      cell.textLabel?.text = games[indexPath.row].title
      return cell
    }
  }

}

// MARK: UICollectionViewDataSource extension
//extension ViewController: UICollectionViewDataSource {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return 10
//  }
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    guard let cell = collectionView
//      .dequeueReusableCell(withReuseIdentifier: "finishedGameCell",
//                           for: indexPath) as? FinishedGameCell else {
//                            fatalError("Can not cast collectionViewItem to FinishedGameCell")
//    }
//    return cell
//  }
//}
