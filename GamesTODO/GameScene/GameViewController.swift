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
  var game: GameItem?
  var isCreationMode = false
  private let gameImagePicker = ImagePickerDelegator()
  private var datePicker: UIDatePicker?
  private var shouldShiftKeyBoard = false
  private let descriptionPlaceHolder = "GAME DESCRIPTION GOES HERE"
  private var presenter: GameViewPresenter?

  // MARK: - Life cycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.262745098, green: 0.2901960784, blue: 0.3294117647, alpha: 1)
    emptyGameLabel.isHidden = true//(game != nil && !isCreationMode)
    gameImagePicker.addGestureRecognizer(for: posterImageView, callingView: self)
    presenter = GameViewPresenter(presenter: self)

    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.keyboardNotification(notification:)),
                                           name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                           object: nil)
    prepareDatePicker()
    hideKeyboardOnTouch()
    inflateLayoutIfNeeded()
    prepareDescriptionView()
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
      self.keyboardHeightLayoutConstraint?.constant = -endframeSize
    }
    UIView.animate(withDuration: duration,
                   delay: TimeInterval(0),
                   options: animationCurve,
                   animations: { [unowned self] in self.view.layoutIfNeeded() },
                   completion: nil)
  }

  @IBAction func save(_ sender: UIBarButtonItem) {
    guard let title = gameTitleField.text else {
      // TODO: Show error
      return
    }
    if game == nil {
      if let dateString = releaseDateField.text {
        DateFormatter.base.date(from: dateString)
      }
      game = GameItem(title: title, fullDescription: descriptionTextView.text, genre: "genre1",
      releaseDate: Date(), poster: posterImageView.image, isFinished: false)
      game?.releaseDateString = releaseDateField.text ?? ""
      presenter?.save(game: game.unsafelyUnwrapped)
    }
  }
  
  // MARK: - Private methods
  private func prepareDatePicker() {
    let releaseDatePicker = ReleaseDatePicker(forField: releaseDateField)
    datePicker = releaseDatePicker
    releaseDateField.inputView = datePicker
    releaseDateField.tintColor = .clear
  }
  
  private func prepareDescriptionView() {
    descriptionTextView.textColor = descriptionTextView.text == descriptionPlaceHolder ? UIColor.lightGray : UIColor.black
    descriptionTextView.delegate = self
  }
  
  private func inflateLayoutIfNeeded() {
    if game == nil /*&& !isCreationMode*/ { return }
    gameTitleField.text = game?.title
    posterImageView.image = game?.poster ?? #imageLiteral(resourceName: "empty-image")
    releaseDateField.text = game?.releaseDateString
    descriptionTextView.text = game?.fullDescription
  }
}

// MARK: Descritpion UITextViewDelegate
extension GameViewController: UITextViewDelegate {
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    shouldShiftKeyBoard = true
    return true
  }
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == descriptionPlaceHolder {
      textView.text = ""
      textView.textColor = .black
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
// MARK: GameView
extension GameViewController: GameView {
  func error(message: String) {
    show(message: message, with: "Something went wrong")
  }
  
  func succesAdded(game: GameItem) {
    show(message: "Game Succesfully added", with: "Information")
  }
}
