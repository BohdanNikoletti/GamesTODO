//
//  ImagePickerDelegator.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 15.04.2018.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit

class ImagePickerDelegator: NSObject, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
  
  //MARK: - Properties
  private weak var callingView: UIViewController!
  private weak var holder: UIImageView!
  
//  var succesHandler: ((_ url: String)->())?
  
//  //MARK: - Initializer
//  init(forUser userType: String = "", autoUpload: Bool = true){
//    self.userType = userType
//    self.autoUpload = autoUpload
//  }
//
  //MARK: - Actions
  @objc func imageClicked(_ sender: UIImage) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    
    let alert = UIAlertController(title: "Add Photo", message: "Choose game photo", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Library", style: .default, handler: {
      [unowned self] action in
      imagePicker.sourceType = .photoLibrary
      self.callingView.present(imagePicker, animated: true, completion: nil)
    }))
//    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
//      action in
//      isPermission(granted: {
//        [unowned self] in
//        imagePicker.sourceType = .camera
//        self.callingView.present(imagePicker, animated: true, completion: nil)
//        }, denied: {
//          [unowned self] in
//          self.callingView.showFailureAlertDialog(title: "Need camera permission",
//                                                  errorDescription: "Please go to setting and allow app to use camera")
//      })
//      
//    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
    callingView.present(alert, animated: true)
  }
  
  //MARK: - Public methods
  func addGestureRecognizer(for holder: UIImageView, callingView: UIViewController){
    self.callingView = callingView
    self.holder = holder
    let singleTap = UITapGestureRecognizer(target: self,
                                           action: #selector(imageClicked(_:)))
    singleTap.numberOfTapsRequired = 1
    holder.isUserInteractionEnabled = true
    holder.addGestureRecognizer(singleTap)
  }
  
  //MARK: - UIImagePickerControllerDelegate method
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : Any]) {
    
    holder.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    picker.dismiss(animated: true, completion: nil)
  }
}
