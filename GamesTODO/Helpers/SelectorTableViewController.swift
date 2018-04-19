//
//  SelectorTableViewController.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 19.04.2018.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

protocol SelectorProtocol: class {
  func didSelect( _ genre: String)
}

final class SelectorTableViewController: UITableViewController {
  
  // MARK: - Properties
  private let genres = ["Action", "RPG", "Strategy", "Shooter", "Simulator"]
  weak var delegate: SelectorProtocol?
  var selectedGame = ""
  
  // MARK: - Lifecycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SelectorCell")
    tableView.tableFooterView = UIView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return genres.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectorCell") else { fatalError("Can not dequeueReusableCell SelectorCell") }
    let genre = genres[indexPath.row]
    cell.textLabel?.text = genre
    cell.textLabel?.textColor = UIColor.AppColors.dark
    cell.accessoryType = selectedGame == genre ? .checkmark : .none
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.didSelect(genres[indexPath.row])
    tableView.visibleCells[indexPath.row].accessoryType = .checkmark
    self.navigationController?.popViewController(animated: true)
  }
}
