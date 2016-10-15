//
//  LoginConroller.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/17/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit
import SwiftLoader
import Firebase

class LoginController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signUp: UIButton!
    var loginSuccess = false
    var loginView = LoginView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        loginView.loginBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        loginView.signUpBtn.addTarget(self, action: #selector(switchToSignIn), for: .touchUpInside)
        
    }
    
    
    func configureView() {
        
        configureButtons()
        
        self.view.addSubview(loginView)
        
        
    }
    
    override func viewDidLoad() {
//        let prefs = UserDefaults.standard
//        if (prefs.value(forKey: "email") != nil && prefs.value(forKey: "pass") != nil) {
//            User.init(email: prefs.value(forKey: "email") as! String, password: prefs.value(forKey: "pass")as! String, errorCase: {() -> Void in
//                }, closure: {() -> Void in
//                    self.performSegue(withIdentifier: "login", sender: self)
//            })
//        }
//
        configureView()
        //loginView.emailTF.becomeFirstResponder()
    }
    
    
//    @IBAction func signIn(_: AnyObject) {
////        SwiftLoader.show(title: "Loading...", animated: true)
////        User.init(email: emailField.text!, password: passField.text!, errorCase: {() -> Void in
////            SwiftLoader.hide()
////            let nameAlert = UIAlertController(title: "Failed Sign Up", message: "Incorrect Username or password", preferredStyle: UIAlertControllerStyle.alert)
////            nameAlert
////            nameAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
////            self.present(nameAlert, animated: true, completion: nil)
////            self.loginSuccess = false
////        }, closure: {() -> Void in
////            SwiftLoader.hide()
////            self.loginSuccess = true
////            self.performSegue(withIdentifier: "login", sender: self)
////        })
//    
//    }
    
    func buttonAction(sender: UIButton!){
        SwiftLoader.show(title: "Signing in", animated: true)
        let animateBtn: UIButton = sender
        FIRAuth.auth()?.signIn(withEmail: loginView.emailTF.text!, password: loginView.emailTF.text!) { (user, error) in
            SwiftLoader.hide()
            if error == nil {
                User.uid = user?.uid
            } else {
                print(error.customMirror)
                let signInAlert = UIAlertController(title: "Failed Sign In", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                signInAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
                self.present(signInAlert, animated: true, completion: nil)
            }
        }
        if animateBtn.isTouchInside == true {
            animateBtn.backgroundColor = UIColor.lightGray
            }
    
    }
    
    func switchToSignIn(sender: UIButton){
        
//        var signupView = RegistrationView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
//        self.view.addSubview(signupView)
//        loginView.removeFromSuperview()
//        
}
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "login") {
            return loginSuccess
        } else {
            return true
        }
    }
}
