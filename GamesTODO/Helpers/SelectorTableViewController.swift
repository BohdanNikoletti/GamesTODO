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
  
  // MARK: - Lifecycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SelectorCell")
    tableView.tableFooterView = UIView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return genres.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectorCell") else { fatalError("Can not dequeueReusableCell SelectorCell") }
    cell.textLabel?.text = genres[indexPath.row]
    cell.textLabel?.textColor = UIColor.AppColors.dark
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.didSelect(genres[indexPath.row])
    self.navigationController?.popViewController(animated: true)
  }
}
