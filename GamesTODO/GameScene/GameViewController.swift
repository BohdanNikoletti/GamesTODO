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
  @IBOutlet weak private var gameTitleField: UITextField!
  @IBOutlet weak private var posterImageView: UIImageView!
  @IBOutlet weak private var releaseDateField: UITextField!
  @IBOutlet weak private var descriptionTextView: UITextView!
  @IBOutlet weak private var saveButton: UIBarButtonItem!
  @IBOutlet weak private var keyboardHeightLayoutConstraint: NSLayoutConstraint?
  @IBOutlet weak private var finishedSwitch: UISwitch!
  @IBOutlet weak private var genreField: UITextField!
  
  // MARK: - Properties
  var game: GameItem?
  var isFinishedGame = false
  private let gameImagePicker = ImagePickerDelegator()
  private var datePicker: UIDatePicker?
  private var shouldShiftKeyBoard = false
  private let descriptionPlaceHolder = "GAME DESCRIPTION GOES HERE"
  private var presenter: GameViewPresenter?
  private let titleFieldTAG = 1
//  private var keyBoardToolBar: UIToolbar {
//    let toolBar = UIToolbar()
//    toolBar.sizeToFit()
//    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.descriptionDoneCLicked))
//    toolBar.setItems([flexibleSpace, doneButton], animated: true)
//    return toolBar
//  }
  // MARK: - Life cycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareView()
    setTextFieldsDelegates()
    prepareDatePicker()
    hideKeyboardOnTouch()
    inflateLayoutIfNeeded()
    prepareDescriptionViewAndKeyboardHandler()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    gameTitleField.becomeFirstResponder()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    prepareTextFieldsUI()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Actions
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
      let endframeSize = endFrame?.size.height ?? 0
      self.keyboardHeightLayoutConstraint?.constant = -endframeSize+32
    }
    UIView.animate(withDuration: duration,
                   delay: TimeInterval(0),
                   options: animationCurve,
                   animations: { [unowned self] in self.view.layoutIfNeeded() },
                   completion: nil)
  }
  
  @objc func descriptionDoneCLicked() {
    dismissKeyboard()
  }
  
  @IBAction func save(_ sender: UIBarButtonItem) {
    guard let title = gameTitleField.text, !title.isEmpty else {
      show(message: "Set game title please", with: "Oops")
      return
    }
    var releaseDate: Date?
    if let dateString = releaseDateField.text {
      releaseDate = DateFormatter.base.date(from: dateString)
    }
    if let game = self.game {
      let newGameData = GameItem(title: title, fullDescription: descriptionTextView.text, genre: genreField.text,
                                 releaseDate: releaseDate, poster: posterImageView.image, isFinished: finishedSwitch.isOn)
      presenter?.update(game: game, with: newGameData)
    } else {
      
      game = GameItem(title: title, fullDescription: descriptionTextView.text, genre: genreField.text,
                      releaseDate: releaseDate, poster: posterImageView.image, isFinished: finishedSwitch.isOn)
      presenter?.save(game: game.unsafelyUnwrapped)
    }
    dismissKeyboard()
    
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    guard let selectorController = segue.destination as? SelectorTableViewController else { return }
    selectorController.delegate = self
    selectorController.selectedGame = genreField.text ?? ""
  }
  
  // MARK: - Private methods
  private func prepareView() {
    navigationController?.navigationBar.tintColor = UIColor.AppColors.dark
    navigationController?.navigationBar.shadowImage = UIImage()
    if game == nil {
      title = "Create Game"
      saveButton.title = "Save"
    } else {
      title = "Edit game"
      saveButton.title = "Update"
    }
    gameImagePicker.addGestureRecognizer(for: posterImageView, callingView: self)
    presenter = GameViewPresenter(presenter: self)
//    gameTitleField.delegate = self
//    gameTitleField.inputAccessoryView = keyBoardToolBar
  }
  
  private func prepareDatePicker() {
    let releaseDatePicker = ReleaseDatePicker(forField: releaseDateField)
    datePicker = releaseDatePicker
    releaseDateField.inputView = datePicker
    releaseDateField.tintColor = .clear
  }
  
  private func inflateLayoutIfNeeded() {
    finishedSwitch.isOn = isFinishedGame
    guard let game = self.game else { return }
    gameTitleField.text = game.title
    posterImageView.image = game.poster ?? #imageLiteral(resourceName: "empty-image")
    releaseDateField.text = game.releaseDateString
    descriptionTextView.text = game.fullDescription
    genreField.text = game.genre
    finishedSwitch.setOn(game.isFinished, animated: true)
  }
  
  private func prepareDescriptionViewAndKeyboardHandler() {
    descriptionTextView.textColor = descriptionTextView.text == descriptionPlaceHolder ? UIColor.lightGray : UIColor.black
    descriptionTextView.delegate = self
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.keyboardNotification(notification:)),
                                           name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                           object: nil)
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.descriptionDoneCLicked))
    toolBar.setItems([flexibleSpace, doneButton], animated: true)
    descriptionTextView.inputAccessoryView = toolBar
  }
  
  private func prepareTextFieldsUI() {
    releaseDateField.setBottomBorderStyle()
    genreField.setBottomBorderStyle()
  }
  
  private func setTextFieldsDelegates() {
    genreField.delegate = self
    gameTitleField.delegate = self
  }
}

// MARK: - Descritpion UITextViewDelegate
extension GameViewController: UITextViewDelegate {
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    shouldShiftKeyBoard = true
    return true
  }
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == descriptionPlaceHolder {
      textView.text = ""
      textView.textColor = UIColor.AppColors.dark
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = descriptionPlaceHolder
      textView.textColor = .lightGray
    }
    textView.resignFirstResponder()
    shouldShiftKeyBoard = false
  }
}
// MARK: - UITextFieldDelegate extension
extension GameViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if textField.tag == titleFieldTAG { return true }
    dismissKeyboard()
    performSegue(withIdentifier: "showGenres", sender: self)
    return false
  }

  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    
    return textField.tag == titleFieldTAG
  }
}
// MARK: - GameView & SelectorProtocol methods
extension GameViewController: GameView, SelectorProtocol {
  func error(message: String) {
    show(message: message, with: "Something went wrong")
  }
  
  func succesAdded(game: GameItem) {
    show(message: "\(game.title) Succesfully added", with: "Information")
  }
  
  func succesUpdated(game: GameItem) {
    show(message: "\(game.title) Succesfully updated", with: "Information")
  }
  
  func didSelect(_ genre: String) {
    self.genreField.text = genre
  }
}
