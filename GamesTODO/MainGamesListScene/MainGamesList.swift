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
  private var presenter: MainGamesListPresenster?
  private var games: [GameItem] = []
  private var finishedGames: [GameItem] = []
  private let finishedGamesSourceDelegator = FinishedGamesDataSourceDelegate()
  private let finishedGamesCellHeight: CGFloat = 100

  // MARK: - Life cycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = MainGamesListPresenster(presenter: self)
    prepareTableView()
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
    contentTable.delegate = self
    contentTable.dataSource = self
    contentTable.allowsSelectionDuringEditing = false
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    guard let gameDetail = segue.destination as? GameViewController else { return }
    if segue.identifier == "addNewFinishedGame" { gameDetail.isFinishedGame = true }
    if let selectedTodoGame = contentTable.indexPathForSelectedRow?.row,
      games.count > selectedTodoGame {
      gameDetail.game = games[selectedTodoGame]
    } else if let finishedGamesCollection = contentTable.visibleCells.first as? FinishedGamesCell,
      let selectedFinishedGame = finishedGamesCollection.selectedIndexPath?.row,
        finishedGames.count > selectedFinishedGame {
      gameDetail.game = finishedGames[selectedFinishedGame]
    }
  }
}

extension MainGamesList: UITableViewDelegate, UITableViewDataSource {
  // MARK: - UITableViewDelegate methdos
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return finishedGamesCellHeight
    } else if indexPath.section == 1 && games.isEmpty {
      tableView.isScrollEnabled = false
      return tableView.frame.height - finishedGamesCellHeight
    }
    tableView.isScrollEnabled = true
    return 76//UITableViewAutomaticDimension
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
    label.textColor = UIColor.AppColors.primary
    label.text = section == 0 ? "Finished games" : "Games to play"
    label.backgroundColor = UIColor.AppColors.dark
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
      cell.setCollectionViewDataSourceDelegate(finishedGamesSourceDelegator, forRow: indexPath.row)
      cell.selectionStyle = .none
      return cell
    } else if !games.isEmpty {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as? GameTableViewCell else {
        fatalError("Can not cast gameCell to GameTableViewCell")
      }
      let game = games[indexPath.row]
      cell.title = game.title
      cell.genre = game.genre
      cell.poster = game.poster
      return cell
    } else {
      let emptyCell = tableView.dequeueReusableCell(withIdentifier: "emptyGamesCell")
      return emptyCell.unsafelyUnwrapped
    }
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return indexPath.section != 0 && !games.isEmpty
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let game = games.remove(at: indexPath.row)
      presenter?.delete(game)
      if games.isEmpty {
        tableView.reloadData()
      } else {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
    }
  }
}
// MARK: - MainGamesListView methods
extension MainGamesList: MainGamesListView {
  
  func error(message: String) {
    show(message: message, with: "Something went wrong")
  }
  
  func show(games: [GameItem]) {
    self.finishedGames = games.filter { $0.isFinished }
    self.games = games.filter { !$0.isFinished }
    finishedGamesSourceDelegator.games = finishedGames
    contentTable.reloadData()
  }
  
  func show(game: GameItem) {
    self.navigationController?.performSegue(withIdentifier: "showDetails", sender: self)
  }
  
}
