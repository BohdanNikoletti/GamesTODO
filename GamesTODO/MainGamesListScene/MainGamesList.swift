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
//  private let gamesListDelegate = GamesListDelegate()
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
    contentTable.delegate = self//gamesListDelegate
    contentTable.dataSource = gamesListDataSource
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let gameDetail = segue.destination as? GameViewController else { return }
    gameDetail.game = GameItem(title: "Title", fullDescription: "Description", genre: "Genre", releaseDate: Date(), poster: nil)
//    gameDetail.isCreationMode = segue.identifier
  }
}

extension MainGamesList: UITableViewDelegate {
  // MARK: - UITableViewDelegate methdos
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return indexPath.section == 0 ? 100 : UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.01
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 { return }
    performSegue(withIdentifier: "showDetails", sender: self)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = #colorLiteral(red: 1, green: 0.8078431373, blue: 0.3294117647, alpha: 1)
    label.text = section == 0 ? "Finished games" : "Games to play"
    label.backgroundColor = #colorLiteral(red: 0.3960784314, green: 0.4274509804, blue: 0.4705882353, alpha: 1)
    return label
  }
}

extension MainGamesList: UISplitViewControllerDelegate {
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

extension MainGamesList: MainGamesListView {
  
  func error(message: String) {
    print(message)
  }
  
  func show(games: [GameItem]) {
    print(games)
  }
  
  func show(game: GameItem) {
    self.navigationController?.performSegue(withIdentifier: "showDetails", sender: self)
  }

}
