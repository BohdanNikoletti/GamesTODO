//
//  UIViewController+.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 15.04.2018.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
typealias AppAlertAction = (action: (() -> Void )?, name: String)

extension UIViewController {
  
  func show(message: String?, with title: String?,
            succesActionHandler:AppAlertAction? = nil,
            destructiveActionHandler: AppAlertAction? = nil) {
    let baseAlert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
    func alerActionHandler (_ action: UIAlertAction) {
      succesActionHandler?.action?()
    }
    func destructiveAlerActionHandler (_ action: UIAlertAction) {
      destructiveActionHandler?.action?()
    }
    if let alertActionTittle = succesActionHandler?.name {
      baseAlert.addAction(UIAlertAction(title: alertActionTittle, style: .default, handler: alerActionHandler))
    }
    if let destructiveActionTittle = destructiveActionHandler?.name{
      baseAlert.addAction(UIAlertAction(title: destructiveActionTittle, style: .destructive, handler: destructiveAlerActionHandler))
    }
    if baseAlert.actions.isEmpty { // create default action
      baseAlert.addAction(UIAlertAction(title: "OK", style: .default))
    }
    present(baseAlert, animated: true, completion: nil)
  }
  
  func hideKeyboardOnTouch() {
    let tap  = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
}
