//
//  GamesListDelegate.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 15.04.2018.
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
