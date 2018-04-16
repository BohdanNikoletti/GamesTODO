//
//  ImagePickerDelegator.swift
//  GamesTODO
//
//  Created by Bohdan Mihiliev on 15.04.2018.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import UIKit
import AVFoundation

final class ImagePickerDelegator: NSObject {
  
  // MARK: - Properties
  private weak var callingView: UIViewController!
  private weak var holder: UIImageView!

  // MARK: - Actions
  @objc func imageClicked(_ sender: UIImage) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    
    let alert = UIAlertController(title: "Add Photo", message: "Choose game photo", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Library", style: .default, handler: { [unowned self] _ in
      imagePicker.sourceType = .photoLibrary
      self.callingView.present(imagePicker, animated: true, completion: nil)
    }))
    alert.addAction(UIAlertAction(title: "Camera",
                                  style: .default,
                                  handler: { [unowned self] _ in
      self.isPermission(granted: {
        [unowned self] in
        imagePicker.sourceType = .camera
        self.callingView.present(imagePicker, animated: true, completion: nil)
        }, denied: {
          [unowned self] in
          self.callingView.show(message: "Need camera permission", with: "Please go to setting and allow app to use camera")
      })
      
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
    callingView.present(alert, animated: true)
  }
  
  // MARK: - Public methods
  func addGestureRecognizer(for holder: UIImageView, callingView: UIViewController) {
    self.callingView = callingView
    self.holder = holder
    let singleTap = UITapGestureRecognizer(target: self,
                                           action: #selector(imageClicked(_:)))
    singleTap.numberOfTapsRequired = 1
    holder.isUserInteractionEnabled = true
    holder.addGestureRecognizer(singleTap)
  }
  
  // MARK: - Privaet methdos
  func isPermission(granted: @escaping() -> Void, denied: @escaping() -> Void) {
    if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
      DispatchQueue.main.async { granted() }
    } else {
      AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (access: Bool) -> Void in
        if access {
          DispatchQueue.main.async { granted() }
        } else {
          denied()
        }
      })
    }
  }
}

// MARK: - UIImagePickerControllerDelegate method
extension ImagePickerDelegator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String: Any]) {
    
    holder.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    picker.dismiss(animated: true, completion: nil)
  }
}
