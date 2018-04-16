//
//  ReleaseDatePicker.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 15.04.2018.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class ReleaseDatePicker: UIDatePicker {
  
  // MARK: - Properties
  private let dateFormatter = DateFormatter.base
  private weak var inputField: UITextField?
  
  // MARK: - Initializers
  required init(coder aDecoder: NSCoder) {
    fatalError("Not implemented")
  }
  
  init(forField inputField: UITextField) {
    super.init(frame: CGRect.zero)
    self.inputField = inputField
    dateFormatter.dateFormat = "dd/MM/yyyy"
    self.datePickerMode = .date
    self.addTarget(self, action: #selector(self.datePicked(_:)), for: .valueChanged)
    setPickerRange()
    inputField.delegate = self
  }
  
  // MARK: - Actions
  @objc func datePicked(_ sender: UIDatePicker) {
    inputField?.text = dateFormatter.string(from: self.date)
  }
  
  // MARK: - Private methods
  private func setPickerRange() {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    self.minimumDate = formatter.date(from: "1970")
    self.maximumDate = Calendar.current.date(byAdding: .year, value: 5, to: Date())
  }
}
extension ReleaseDatePicker: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    return false
  }
}
