//
//  ViewController.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 4/12/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class MainGamesList: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak private var contentTable: UITableView!
  
  // MARK: - Properties
  private let gamesListDataSource = GamesListDataSource()
  private let gamesListDelegate = GamesListDelegate()
  private var presenter: MainGamesListPresenster?
  
  // MARK: - Life cycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = MainGamesListPresenster(presenter: self)
    splitViewController?.delegate = self
    prepareTableView()

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Private methods
  private func prepareTableView() {
    contentTable.delegate = gamesListDelegate
    contentTable.dataSource = gamesListDataSource
  }
  
  // MARK: - Navigation
  
}

extension MainGamesList:  UISplitViewControllerDelegate {
  func splitViewController(_ splitViewController: UISplitViewController,
                           collapseSecondary secondaryViewController: UIViewController,
                           onto primaryViewController: UIViewController) -> Bool {
    if let gameViewController = secondaryViewController as? GameViewController {
      if gameViewController.game == nil {
        return true
      }
    }
    return false
  }
}

extension MainGamesList: MainGamesListPresensterProtocol {
  
  func error(message: String) {
    print(message)
  }
  
  func show(games: [Game]) {
    print(games)
  }
  
  func didPick(game: Game) {
    self.navigationController?.performSegue(withIdentifier: "showDetails", sender: self)
  }

}
