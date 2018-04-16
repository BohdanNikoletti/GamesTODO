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
            succesActionHandler: (() -> Void )? = nil,
            destructiveActionHandler: (() -> Void )? = nil) {
    let baseAlert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
    func alerActionHandler (_ action: UIAlertAction) {
      succesActionHandler?()
    }
    func destructiveAlerActionHandler (_ action: UIAlertAction) {
      destructiveActionHandler?()
    }
    baseAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: alerActionHandler))
    baseAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: alerActionHandler))

    present(baseAlert, animated: true, completion: nil)
  }
  
//  func error(handler: (() -> Void )?, for error: Error?) {
//
//    if let handler = handler {
//      handler()
//    } else {
//      self.show(failure: error?.localizedDescription, with: "Error")
//    }
//
//  }
  
  func hideKeyboardOnTouch() {
    let tap  = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
}
