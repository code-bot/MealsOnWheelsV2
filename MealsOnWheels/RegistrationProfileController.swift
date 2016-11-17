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
import SwiftyJSON

class RegistrationProfileController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    

    let picker = UIImagePickerController()
    var image:UIImage?
    var imagePicker: UIImagePickerController!
    var ref = FIRDatabase.database().reference()

    
    var registrationProfileView = RegistrationProfileView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {

        registrationProfileView.photoimageBtn.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
       // registrationProfileView.photoimageBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        registrationProfileView.signUpBtn.addTarget(self, action: #selector(storeData), for: .touchUpInside)

    }
    
    func pickImage() {
        picker.allowsEditing = true;
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    /**
    @IBAction func photoFromLibrary(_sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        picker.popoverPresentationController?.barButtonItem = _sender
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
    }**/
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (registrationProfileView.firstNameTF.isEditing){
            registrationProfileView.lastNameTF.becomeFirstResponder()
            return true
        }
        else if (registrationProfileView.lastNameTF.isEditing){
            registrationProfileView.phoneNumberTF.becomeFirstResponder()
            return true
        }
        else if (registrationProfileView.phoneNumberTF.isEditing){
            //let numberList = registrationProfileView.phoneNumberTF.text?.characters
            //let indexNL  = numberList?.index((numberList?.startIndex)!, offsetBy: 0)
           // if ((registrationProfileView.phoneNumberTF.text?.characters.count == 10)){
                registrationProfileView.phoneNumberTF.resignFirstResponder()
                storeData()
                return true
                //}
            }

        return false
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

     func storeData() {
        SwiftLoader.show(title: "Saving Data", animated: true)
        let name = registrationProfileView.firstNameTF.text! + " " + registrationProfileView.lastNameTF.text!
        User.currentUser?.name = name
        self.ref.child("users").child(User.currentUser!.uid!).child("name").setValue(name)
        self.ref.child("users").child(User.currentUser!.uid!).child("phone").setValue(registrationProfileView.phoneNumberTF.text)
        self.ref.child("users").child(User.currentUser!.uid!).child("image").setValue(UIImageJPEGRepresentation(image!, 0.5)?.base64EncodedString())
        self.ref.child("users").child(User.currentUser!.uid!).child("routes").observeSingleEvent(of: .value, with: { (snapshot) in
                                    SwiftLoader.hide()
                                    if snapshot.exists() {
                                        
                                        let routes = snapshot.value as? NSArray
                                        for (route) in routes! {
                                            
                                            self.ref.child("routes").child(route as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                                                SwiftLoader.hide()
                                                User.currentUser!.routes.append(Route(dict: JSON(snapshot.value as Any)))
                                                User.currentUser!.route = User.currentUser!.routes.first
                                                
                                            })
                                        }
                                    } else {

                                    }
                                    self.present(MainViewController(), animated: true, completion: {
                                    })
            
                                }) { (error) in
                                    print(error.localizedDescription)
                                    SwiftLoader.hide()
                                }

        
    }
    

    func configureView() {
        configureButtons()
        self.dismissKeyboardAtTap()
        self.view.addSubview(registrationProfileView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        picker.delegate = self
        self.registrationProfileView.firstNameTF.delegate = self
        self.registrationProfileView.lastNameTF.delegate = self
        self.registrationProfileView.phoneNumberTF.delegate = self
        
}
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,                              didFinishPickingMediaWithInfo info: [String : Any]){
        
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.image = chosenImage
            registrationProfileView.photoimageBtn.contentMode = .scaleAspectFill
            registrationProfileView.photoimageBtn.clipsToBounds = true
            registrationProfileView.photoimageBtn.setImage(chosenImage, for: .normal)
            
        }

        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)

    }

}

