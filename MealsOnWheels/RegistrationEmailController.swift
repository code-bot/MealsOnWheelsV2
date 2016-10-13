//
//  RegistrationEmailController.swift
//  MealsOnWheels
//
//  Created by Taabish Kathawala on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import SwiftLoader
import UIKit

class RegistrationEmailController : UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var passConfirmField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    var passConfirm = false
    var registrationView = RegistrationView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        
    }
    
    func configureView() {
        configureButtons()
        self.view = registrationView
    }
    
    
    override func viewDidLoad() {
        let prefs = UserDefaults.standard
        if (prefs.value(forKey: "email") != nil && prefs.value(forKey: "password") != nil && prefs.value(forKey: "confirmPass") != nil) {
            confirmPasswords(sender: AnyObject.self as AnyObject)
            }
            
        
        configureView()
    }
    
    @IBAction func confirmPasswords(sender: AnyObject) {
        SwiftLoader.show(title: "Loading...", animated: true)
        User.init(email: emailField.text!, password: passField.text!, errorCase: {() -> Void in
            SwiftLoader.hide()
            let signUpAlert = UIAlertController(title: "Failed Sign Up", message: "Incorrect Email and Password", preferredStyle: UIAlertControllerStyle.alert)
            signUpAlert
            signUpAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
            self.passConfirm = false
            }, closure: {() -> Void in
                SwiftLoader.hide()
                self.passConfirm = true
                self.performSegue(withIdentifier: "Sign Up", sender: self)
            
            
            
            
//            if passField.text.isEmpty || passConfirmField.text.isEmpty {
//                passConfirm = false
//                SwiftLoader.hide()
//                let emptyFields = UIAlertController(title: "Failed Sign Up", message: "Please Enter in a Password and Confirm", preferredStyle: UIAlertController.alert)
//            emptyFields
//            emptyFields.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel, handler: nil))}
//            if passField.text != passConfirmField.text {
//                passConfirm = false
//                    {() -> Void in
//                        SwiftLoader.hide()
//                let wrongConfirm = UIAlertController(title: "Failed Sign Up", message: "Your Password Does Not Match Confirm Password", preferredStyle: UIAlertControllerStyle.alert)
//                wrongConfirm
//                wrongConfirm.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel, handler: nil))
//                self.passConfirm = false

        })
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "Sign Up") {
            return passConfirm
        } else {
            return true
        }
    }
    

}

