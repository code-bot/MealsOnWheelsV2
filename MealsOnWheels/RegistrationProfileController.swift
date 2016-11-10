//
//  RegistrationProfileController.swift
//  MealsOnWheels
//
//  Created by Taabish Kathawala on 10/20/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation
import SwiftLoader
import UIKit
import Firebase

class RegistrationProfileController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var photoimage: UIButton!
    @IBOutlet weak var signupbtn: UIButton!
    @IBOutlet weak var phoneNumberTF: UITextView!
    let picker = UIImagePickerController()
    
    var registrationProfileView = RegistrationProfileView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        registrationProfileView.photoimageBtn.addTarget(self, action: #selector(imagePickerControllerDidCancel), for: .touchUpInside)
    }
    
    @IBAction func photoFromLibrary(_sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        picker.popoverPresentationController?.barButtonItem = sender
    }
    
    @IBAction func shootPhoto(_sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.camera)  {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    func noCamera() {
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
//    @IBAction func btnClicked(_ sender: AnyObject){
//        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
//            print("Button Capture")
//            
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
//            imagePicker.allowsEditing = false
//            
//            self.present(imagePicker, animated: true, completion: nil)
//        }
//    }
    

    func configureView() {
        configureButtons()
        self.dismissKeyboardAtTap()
        self.view.addSubview(registrationProfileView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        picker.delegate = self
}
     func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject] ) {
        var chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage]
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoimage.contentMode = .scaleAspectFit
            photoimage.setImage(pickedImage, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.imagePicker = UIImagePickerController()
        dismiss(animated: true, completion: nil)

    }

}

