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
  //  private let gamesListDataSource = GamesListDataSource()
  //  private let gamesListDelegate = GamesListDelegate()
  private var presenter: MainGamesListPresenster?
  private var games: [GameItem] = [] //GameItem(title: "Test1", fullDescription: "fullDescription1", genre: "genre1",releaseDate: Date(), poster: nil, isFinished: false)
  private var finishedGames: [GameItem] = []
  private let delegatTest = FinishedGamesDataSourceDelegate()
  
  // MARK: - Life cycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = MainGamesListPresenster(presenter: self)
    splitViewController?.delegate = self
    prepareTableView()
    delegatTest.games = finishedGames
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presenter?.getGames()
    
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Private methods
  private func prepareTableView() {
    contentTable.delegate = self//gamesListDelegate
    contentTable.dataSource = self// gamesListDataSource
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let gameDetail = segue.destination as? GameViewController else { return }
    if segue.identifier == "addNewgame" { gameDetail.isCreationMode = true; return }
    if let selectedTodoGame = contentTable.indexPathForSelectedRow?.row {
      if games.count > selectedTodoGame {
        gameDetail.game = games[selectedTodoGame]
      }
    } else if let finishedGamesCollection = contentTable.visibleCells.first as? FinishedGamesCell,
      let selectedFinishedGame = finishedGamesCollection.selectedIndexPath?.row {
      gameDetail.game = finishedGames[selectedFinishedGame]
    }
  }
}

extension MainGamesList: UITableViewDelegate, UITableViewDataSource {
  // MARK: - UITableViewDelegate methdos
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 100
    } else if indexPath.section == 1 && games.isEmpty {
      tableView.isScrollEnabled = false
      return tableView.frame.height - 100
    }
    tableView.isScrollEnabled = true
    return UITableViewAutomaticDimension
    //    return indexPath.section == 0 ? 100 : UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.01
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 || games.isEmpty { return }
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
  
  // MARK: UITableViewDataSource methdos
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : (games.isEmpty ? 1 : games.count)
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
      cell.selectionStyle = .none
      return cell
    } else if !games.isEmpty {
      var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
      if cell == nil {
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
      }
      cell?.textLabel?.text = games[indexPath.row].title
      cell?.detailTextLabel?.text = games[indexPath.row].genre
      cell?.imageView?.image = games[indexPath.row].poster ?? #imageLiteral(resourceName: "empty-image")
      cell?.accessoryType = .disclosureIndicator
      return cell.unsafelyUnwrapped
    } else {
      let emptyCell = tableView.dequeueReusableCell(withIdentifier: "emptyGamesCell")
      return emptyCell.unsafelyUnwrapped
    }
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
    finishedGames = games.filter { $0.isFinished }
    self.games = games.filter { !$0.isFinished }
    contentTable.reloadData()
  }
  
  func show(game: GameItem) {
    self.navigationController?.performSegue(withIdentifier: "showDetails", sender: self)
  }
  
}
