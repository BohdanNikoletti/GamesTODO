//
//  ViewController.swift
//  GamesTODO
//
//  Created by Soft Project on 4/12/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class GamesListDelegate: NSObject, UITableViewDelegate {
 
  // MARK: - UITableViewDelegate methdos
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return indexPath.section == 0 ? 100 : UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.01
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.font = UIFont.systemFont(ofSize: 16)
    label.text = section == 0 ? "Finished games" : "Games to play"
    label.backgroundColor = #colorLiteral(red: 0.8820130229, green: 0.9472284913, blue: 0.9974038005, alpha: 1)
    return label
  }
}

final class FinishedGamesDataSourceDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
  
  // MARK: - UICollectionViewDelegate & UICollectionViewDataSource methods
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
                            fatalError("Can not cast finishedGameCell to FinishedGameCell")
    }
    return cell
  }
}

final class GamesListDataSource: NSObject, UITableViewDataSource {
  // MARK: - Properties
  var games: [Game] = [ Game(title: "Test", description: "Test", genre: "Genre", releaseDate: Date(), poster: nil)]
  private let delegatTest = FinishedGamesDataSourceDelegate()
  
  // MARK: - UITableViewDataSource methdos
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
                              fatalError("can not cast finishedGamesCell to FinishedGamesCell")
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


final class MainGamesList: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak private var contentTable: UITableView!
  
  // MARK: - Properties
  private let gamesListDataSource = GamesListDataSource()
  private let gamesListDelegate = GamesListDelegate()
  
  // MARK: - Life cycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareTableView() 
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Private methods
  private func prepareTableView() {
    contentTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    contentTable.delegate = gamesListDelegate
    contentTable.dataSource = gamesListDataSource
  }
}
