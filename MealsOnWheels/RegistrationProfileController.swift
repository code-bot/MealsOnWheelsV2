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
    
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        {
            if (textField == registrationProfileView.phoneNumberTF)
            {
                let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
                let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
    
                let decimalString = components.joined(separator: "") as NSString
                let length = decimalString.length
                let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
    
                if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
                {
                    let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
    
                    return (newLength > 10) ? false : true
                }
                var index = 0 as Int
                let formattedString = NSMutableString()
    
                if hasLeadingOne
                {
                    formattedString.append("1 ")
                    index += 1
                }
                if (length - index) > 3
                {
                    let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                    formattedString.appendFormat("(%@) ", areaCode)
                    index += 3
                }
                if length - index > 3
                {
                    let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                    formattedString.appendFormat("%@-", prefix)
                    index += 3
                }
    
                let remainder = decimalString.substring(from: index)
                formattedString.append(remainder)
                textField.text = formattedString as String
                return false
            }
            else
            {
                return true
            }
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
//                                }) { (error) in
//                                    print(error.localizedDescription)
//                                    SwiftLoader.hide()
//                                }
//
//        
//    }
//    
//
//    func configureView() {
//        configureButtons()
//        self.dismissKeyboardAtTap()
//        self.view.addSubview(registrationProfileView)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureView()
//        picker.delegate = self
//}
//     func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject] ) {
//        var chosenImage = UIImage()
//        chosenImage = info[UIImagePickerControllerOriginalImage]
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            photoimage.contentMode = .scaleAspectFit
//            photoimage.setImage(pickedImage, for: .normal)
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }

     func storeData() {
        SwiftLoader.show(title: "Saving Data", animated: true)
        let name = registrationProfileView.firstNameTF.text! + " " + registrationProfileView.lastNameTF.text!
        User.currentUser?.name = name
        self.ref.child("users").child(User.currentUser!.uid!).child("name").setValue(name)
        self.ref.child("users").child(User.currentUser!.uid!).child("phone").setValue(registrationProfileView.phoneNumberTF.text)
        if ((image) != nil) {
            self.ref.child("users").child(User.currentUser!.uid!).child("image").setValue(UIImageJPEGRepresentation(image!, 0.5)?.base64EncodedString())
        } else {
            self.ref.child("users").child(User.currentUser!.uid!).child("image").setValue(UIImageJPEGRepresentation(#imageLiteral(resourceName: "default-user-image.png"), 0.5)?.base64EncodedString())
        }
        self.ref.child("routes").observeSingleEvent(of: .value, with: {(snapshot) in
            let response = JSON(snapshot.value as! NSDictionary)
            for (_ , subJson) in response {
                User.currentUser!.routes.append(Path(dict: subJson))
            }
            SwiftLoader.hide()
            self.present(MainViewController(), animated: true, completion: {
            })
            
        })
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

