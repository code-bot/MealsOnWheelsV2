//
//  ForgotPasswordController.swift
//  MealsOnWheels
//
//  Created by Rahul Ajmera on 10/20/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation
import UIKit
import SwiftLoader
import Firebase

class ForgotPasswordController: UIViewController{
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    
    //var loginSuccess = false
    var forgotPassword = ForgotPasswordView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        
        
    }
    
    
    func configureView() {
        
        configureButtons()
        
        self.view.addSubview(forgotPassword)
        
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        recognizer.direction = .right
        self.view.addGestureRecognizer(recognizer)
        
        
    }
    
    override func viewDidLoad() {
        
        configureView()
        self.dismissKeyboardAtTap()
//        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
//        recognizer.direction = .left
//        self.view.addGestureRecognizer(recognizer)
    }
    
    
    func swipeLeft(){
        dismiss(animated: false, completion: nil)
        present(LoginController(), animated: true, completion: nil)
    
    }
    
//    func buttonAction(sender: UIButton!){
//        SwiftLoader.show(title: "Signing in", animated: true)
//        let animateBtn: UIButton = sender
//        FIRAuth.auth()?.signIn(withEmail: loginView.emailTF.text!, password: loginView.passwordTF.text!) { (user, error) in
//            SwiftLoader.hide()
//            if error == nil {
//                
//                _ = User()
//                User.uid = user?.uid
//                self.present(MainViewController(), animated: true, completion: {
//                    
//                })
//            } else {
//                let signInAlert = UIAlertController(title: "Failed Sign In", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
//                signInAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
//                self.present(signInAlert, animated: true, completion: nil)
//            }
//        }
//        
//        //animateBtn .setTitle("Logging In...", for: .highlighted)
//    }
    
//    func switchToSignIn(sender: UIButton){
//        
//        //dismiss(animated: false, completion: nil)
//        present(RegistrationController(), animated: true, completion: nil)
//        dismiss(animated: false, completion: nil)
//    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if (identifier == "login") {
//            return loginSuccess
//        } else {
//            return true
//        }
//    }


}
