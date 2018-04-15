//
//  GameViewController.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 15.04.2018.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

final class GameViewController: UIViewController {
  // MARK: - Outlets
  @IBOutlet weak var gameTitleField: UITextField!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var releaseDateField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint?
  @IBOutlet weak var emptyGameLabel: UILabel!

  // MARK: - Properties
  var game: Game?
  var isCreationMode = false
  private let gameImagePicker = ImagePickerDelegator()
  private var datePicker: UIDatePicker!
  private var shouldShiftKeyBoard = false
  // MARK: - Life cycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    
    emptyGameLabel.isHidden = (game != nil && !isCreationMode)
    gameImagePicker.addGestureRecognizer(for: posterImageView, callingView: self)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.keyboardNotification(notification:)),
                                           name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                           object: nil)
    prepareDatePicker()
    prepareDescriptionView()
    hideKeyboardOnTouch()
    inflateLayoutIFNeeded()
  }
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK: - Actions
  @objc func keyboardNotification(notification: NSNotification) {
    guard let userInfo = notification.userInfo, shouldShiftKeyBoard else { return }
    let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    let endFrameY = endFrame?.origin.y ?? 0
    let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
    let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
    let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
    let animationCurve = UIViewAnimationOptions(rawValue: animationCurveRaw)
    if endFrameY >= UIScreen.main.bounds.size.height {
      self.keyboardHeightLayoutConstraint?.constant = 0.0
    } else {
      self.keyboardHeightLayoutConstraint?.constant = -endFrame!.size.height //?? 0.0
    }
    UIView.animate(withDuration: duration,
                   delay: TimeInterval(0),
                   options: animationCurve,
                   animations: {[unowned self] in self.view.layoutIfNeeded() },
                   completion: nil)
  }

  @IBAction func save(_ sender: UIBarButtonItem) {
  }
  
  // MARK: - Private methods
  private func prepareDatePicker() {
    let releaseDatePicker = ReleaseDatePicker(forField: releaseDateField)
    datePicker = releaseDatePicker
    releaseDateField.inputView = datePicker
    releaseDateField.delegate = self
    releaseDateField.tintColor = .clear
  }
  private func prepareDescriptionView() {
    descriptionTextView.text = "GAME DESCRIPTION GOES HERE"
    descriptionTextView.textColor = UIColor.lightGray
    descriptionTextView.delegate = self
  }
  private func inflateLayoutIFNeeded(){
    if (game == nil && !isCreationMode) { return }
    gameTitleField.text = game?.title
    posterImageView.image = game?.poster ?? #imageLiteral(resourceName: "empty-image")
    releaseDateField.text = "test"
    descriptionTextView.text = game?.description
  }
}

extension GameViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    return false
  }
}

extension GameViewController: UITextViewDelegate {
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    shouldShiftKeyBoard = true
    return true
  }
  func textViewDidBeginEditing(_ textView: UITextView){
    if (textView.text == "GAME DESCRIPTION GOES HERE") {
      textView.text = ""
      textView.textColor = .black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView){
    if textView.text.isEmpty {
      textView.text = "GAME DESCRIPTION GOES HERE"
      textView.textColor = .lightGray
    }
    textView.resignFirstResponder()
    shouldShiftKeyBoard = false
  }
}

