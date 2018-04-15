//
//  ReleaseDatePicker.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 15.04.2018.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

class ReleaseDatePicker: UIDatePicker {
  
  // MARK: - Properties
  private let dateFormatter = DateFormatter()
  private weak var inputField: UITextField?
  
  // MARK: - Initializers
  required init(coder aDecoder: NSCoder){
    super.init(coder: aDecoder)!
  }
  
  init(forField inputField: UITextField) {
    super.init(frame: CGRect.zero)
    self.inputField = inputField
    dateFormatter.dateFormat = "dd/MM/yyyy"//yyy/MM/dd"
    self.datePickerMode = .date
    self.addTarget(self, action: #selector(self.datePicked(_:)), for: .valueChanged)
  }
  
  // MARK: - Actions
  @objc func datePicked(_ sender: UIDatePicker){
    inputField?.text = dateFormatter.string(from: self.date)
  }
  
  // MARK: - Public methods
  func setDealPickerRange(){
    self.minimumDate = Calendar.current.date(byAdding: .day, value: 3, to: Date())
    self.maximumDate = Calendar.current.date(byAdding: .year, value: 3, to: Date())
  }
}
