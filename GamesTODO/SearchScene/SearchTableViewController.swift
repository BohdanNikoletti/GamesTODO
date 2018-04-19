//
//  SearchTableViewController.swift
//  GamesTODO
//
//  Created by Soft Project on 4/17/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class SearchTableViewController: UITableViewController {
  
  // MARK: - Outlets
  @IBOutlet weak private var searchBar: UISearchBar!
  
  // MARK: - Properties
  private var games: [GameItem] = []
  private var filteredGames: [GameItem] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  private var presenter: SearchGameViewPresenter?
  
  // MARK: - Lifecycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presenter?.getGames()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - UITableViewDelegate methdos
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 && filteredGames.isEmpty {
      tableView.isScrollEnabled = false
      return tableView.frame.height
    }
    tableView.isScrollEnabled = true
    return 104
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "gameDetail", sender: self)
  }
  
  // MARK: - UITableViewDataSource methdos
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? (filteredGames.isEmpty ? 1 : 0) : filteredGames.count
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 1 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as? GameSearchTableViewCell else {
        fatalError("Can not cast gameCell to GameSearchTableViewCell")
      }
      let game = filteredGames[indexPath.row]
      cell.title = game.title
      cell.subTitle = game.genre
      cell.bottomTitle = game.releaseDateString
      cell.backgroundImage = game.poster
      return cell
    } else { // Empty search cell
      let emptyCell = tableView.dequeueReusableCell(withIdentifier: "emptyGamesCell")
      emptyCell?.isUserInteractionEnabled = false
      return emptyCell.unsafelyUnwrapped
    }
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    guard let gameDetail = segue.destination as? GameViewController else { return }
    if let selectedTodoGame = tableView.indexPathForSelectedRow?.row {
      gameDetail.game = games[selectedTodoGame]
    }
  }
  
  // MARK: - Private methods
  private func prepareView() {
    presenter = SearchGameViewPresenter(presenter: self)
    tableView.tableFooterView = UIView()
    navigationController?.navigationBar.tintColor = UIColor.AppColors.dark
    navigationController?.navigationBar.shadowImage = UIImage()
    searchBar.layer.borderWidth = 1
    searchBar.layer.borderColor = UIColor.AppColors.primary.cgColor
    searchBar.delegate = self
    searchBar.tintColor = UIColor.AppColors.dark
  }
}

// MARK: - SearchGameView Methods
extension SearchTableViewController: SearchGameView {
  func error(message: String) {
    show(message: "Something went wrong(", with: message)
  }
  
  func show(games: [GameItem]) {
    self.games = games
    filteredGames = games
  }
  
}

// MARK: - UISearchBarDelegate extension
extension SearchTableViewController: UISearchBarDelegate {
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(true, animated: true)
    return true
  }
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(false, animated: true)
    searchBar.resignFirstResponder()
  }
  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(false, animated: true)
    return true
  }
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty { filteredGames = games; return }
    NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
    perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.35)
    filteredGames = games.filter { game in
      return game.searchContent.lowercased().contains(searchText.lowercased())
    }
  }
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }

  @objc func reload(_ searchBar: UISearchBar) {
    guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else { return; }
  }
}
