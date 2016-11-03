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
        forgotPassword.submitBtn.addTarget(self, action: #selector(resetPassword(sender:)), for: .touchUpInside)
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
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func swipeLeft(){
        dismiss(animated: false, completion: nil)
        present(LoginController(), animated: true, completion: nil)
    
    }
    
    func resetPassword(sender: UIButton){
        FIRAuth.auth()?.sendPasswordReset(withEmail: forgotPassword.emailTF.text!) { error in
            if let error = error {
                let resetAlert = UIAlertController(title: "Reset Password", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                resetAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
                self.present(resetAlert, animated: true, completion: nil)
            } else {
                let resetAlert = UIAlertController(title: "Reset Password", message: "email successfully sent", preferredStyle: UIAlertControllerStyle.alert)
                resetAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
                self.dismiss(animated: false, completion: nil)
                self.present(resetAlert, animated: true, completion: nil)
                // Password reset email sent.
            }
        }
    }
    


}
