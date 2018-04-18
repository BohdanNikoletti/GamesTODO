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
    if indexPath.section == 0 {
      tableView.isScrollEnabled = false
      return tableView.frame.height
    }
    tableView.isScrollEnabled = true
    return UITableViewAutomaticDimension
  }
  
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.01
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
      var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
      if cell == nil {
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
      }
      cell?.textLabel?.text = filteredGames[indexPath.row].title
      cell?.detailTextLabel?.text = filteredGames[indexPath.row].genre
      cell?.imageView?.image = filteredGames[indexPath.row].poster ?? #imageLiteral(resourceName: "empty-image")
      cell?.accessoryType = .disclosureIndicator
      return cell.unsafelyUnwrapped
    } else { // Empty search
      let emptyCell = tableView.dequeueReusableCell(withIdentifier: "emptyGamesCell")
      emptyCell?.isUserInteractionEnabled = false
      return emptyCell.unsafelyUnwrapped
    }
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let gameDetail = segue.destination as? GameViewController else { return }
    if let selectedTodoGame = tableView.indexPathForSelectedRow?.row {
      gameDetail.game = games[selectedTodoGame]
    }
  }
  
  // MARK: - Private methods
  private func prepareView() {
    presenter = SearchGameViewPresenter(presenter: self)
    navigationController?.navigationBar.tintColor = UIColor.AppColors.dark
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
    if !searchText.isEmpty {
      filteredGames = games.filter { game in
        return game.searchContent.lowercased().contains(searchText.lowercased())
      }
    } else {
      filteredGames = games
    }
  }
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}
