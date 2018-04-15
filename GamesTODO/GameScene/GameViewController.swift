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
  
  // MARK: - Properties
  var game: Game?
  private let gameImagePicker = ImagePickerDelegator()
  
  // MARK: - Life cycle events
  override func viewDidLoad() {
    super.viewDidLoad()
    gameImagePicker.addGestureRecognizer(for: posterImageView, callingView: self)
  
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Actions
  @IBAction func save(_ sender: UIBarButtonItem) {
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
