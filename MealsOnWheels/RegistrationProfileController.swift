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

class RegistrationProfileController : UIViewController, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var photoimage: UIButton!
    @IBOutlet weak var signupbtn: UIButton!
    @IBOutlet weak var phoneNumberTF: UITextView!
    var imagePicker: UIImagePickerController!
    
    var registrationProfileView = RegistrationProfileView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        registrationProfileView.photoimageBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
    }
    
    @IBAction func btnClicked(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
            print("Button Capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject] ) {
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            photoimage.contentMode = .scaleAspectFit
//            photoimage.setImage(pickedImage, for: .normal)
//            }
//        picker.dismiss(animated: true, completion: nil)
//        }
    }
    

    func configureView() {
        configureButtons()
        self.dismissKeyboardAtTap()
        self.view.addSubview(registrationProfileView)
    }
    
    override func viewDidLoad() {
        configureView()

}
    func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [String: AnyObject]) {
        dismiss(animated: true, completion: { () -> Void in
        })
        
        photoimage.setImage(image, for: UIControlState())
}

}

