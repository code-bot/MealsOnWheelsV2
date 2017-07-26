//
//  RegistrationController.swift
//  MealsOnWheels
//
//  Created by Taabish Kathawala on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import SwiftLoader
import UIKit
import Firebase
import SwiftyJSON

class RegistrationController : UIViewController, UITextFieldDelegate {
    
    var passConfirm = false
    var ref = FIRDatabase.database().reference()
    var registrationView = RegistrationView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        registrationView.nextButton.addTarget(self, action: #selector(confirmPasswords),for: .touchUpInside)
    }
    
    func configureView() {
        configureButtons()
        self.view.addSubview(registrationView)
        self.dismissKeyboardAtTap()
        
        
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        recognizer.direction = .right
        self.view.addGestureRecognizer(recognizer)
        
        
    }
    
    func swipeLeft(){
        dismiss(animated: false, completion: nil)
        present(LoginController(), animated: true, completion: nil)
    
    }
    
    
    override func viewDidLoad() {
//        let prefs = UserDefaults.standard
//        if (prefs.value(forKey: "email") != nil && prefs.value(forKey: "password") != nil && prefs.value(forKey: "confirmPass") != nil) {
//            confirmPasswords(sender: AnyObject.self as AnyObject)
//            }
        
        
        configureView()
        self.registrationView.emailTF.delegate = self
        self.registrationView.passTF.delegate = self
        self.registrationView.passConfirmTF.delegate = self
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    func confirmPasswords() {
        SwiftLoader.show(title: "Signing Up", animated: true)
        if registrationView.passTF.text != registrationView.passConfirmTF.text {
            SwiftLoader.hide()
            let signUpAlert = UIAlertController(title: "Failed Sign Up", message: "passwords do not match", preferredStyle: UIAlertControllerStyle.alert)
            signUpAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
            self.present(signUpAlert, animated: true, completion: nil)
        } else {
            ref.child("access_codes").observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.value as! NSArray).contains(self.registrationView.accessCodeTF.text!) {
                    FIRAuth.auth()?.createUser(withEmail: self.registrationView.emailTF.text!, password: self.registrationView.passTF.text!) { (user, error) in
                        User.setCurrentUser()
                        User.currentUser?.access_code = self.registrationView.accessCodeTF.text
                        SwiftLoader.hide()
                        if error == nil {
                            _ = UIButton()
                            self.present(RegistrationProfileController(), animated: true, completion: nil)
                            
                        } else {
                            let signUpAlert = UIAlertController(title: "Failed Sign Up", message: error?.localizedDescription, preferredStyle:  UIAlertControllerStyle.alert)
                            signUpAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
                            self.present(signUpAlert, animated: true, completion: nil)
                        }
                    }
                } else {
                    SwiftLoader.hide()
                    let signUpAlert = UIAlertController(title: "Failed Sign Up", message: "Invalid Acces Code", preferredStyle:  UIAlertControllerStyle.alert)
                    signUpAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
                    self.present(signUpAlert, animated: true, completion: nil)
                }
            }) { (error) in
                SwiftLoader.hide()
                let signUpAlert = UIAlertController(title: "Failed Sign Up", message: error.localizedDescription, preferredStyle:  UIAlertControllerStyle.alert)
                signUpAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
                self.present(signUpAlert, animated: true, completion: nil)

            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(registrationView.emailTF.isEditing){
            registrationView.passTF.becomeFirstResponder()
            return true
        }
        else if registrationView.passTF.isEditing{
            registrationView.passConfirmTF.becomeFirstResponder()
            return true
        }
        else if registrationView.passConfirmTF.isEditing{
            registrationView.passConfirmTF.resignFirstResponder()
            confirmPasswords()
            return true
        }
        return false
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "Sign Up") {
            return passConfirm
        } else {
            return true
        }
    }
    

}

