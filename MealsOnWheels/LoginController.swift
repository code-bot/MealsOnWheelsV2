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
    @IBOutlet weak var forgotPassword: UIButton!
    
    var loginSuccess = false
    var loginView = LoginView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        loginView.loginBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        loginView.signUpBtn.addTarget(self, action: #selector(switchToSignIn), for: .touchUpInside)
        
        loginView.forgotPasswordBtn.addTarget(self, action: #selector(switchToForgotPassword), for: .touchUpInside)
        
        
        
    }
    
    
    func configureView() {
        
        configureButtons()
        
        self.view.addSubview(loginView)
        
        
    }
    
    override func viewDidLoad() {

        configureView()
        self.dismissKeyboardAtTap()
    }
    
    
    func buttonAction(sender: UIButton!){
        SwiftLoader.show(title: "Signing in", animated: true)
        let animateBtn: UIButton = sender
        FIRAuth.auth()?.signIn(withEmail: loginView.emailTF.text!, password: loginView.passwordTF.text!) { (user, error) in
            SwiftLoader.hide()
            if error == nil {
                
                _ = User()
                User.uid = user?.uid
                self.present(MainViewController(), animated: true, completion: {
                    
                })
            } else {
                let signInAlert = UIAlertController(title: "Failed Sign In", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                signInAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
                self.present(signInAlert, animated: true, completion: nil)
            }
        }

        //animateBtn .setTitle("Logging In...", for: .highlighted)
    }
    
    func switchToSignIn(sender: UIButton){
        
        dismiss(animated: false, completion: nil)
        present(RegistrationController(), animated: true, completion: nil)
}
    
    func switchToForgotPassword(sender: UIButton){
        
        dismiss(animated: false, completion: nil)
        present(ForgotPasswordController(), animated: true, completion: nil)
            
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "login") {
            return loginSuccess
        } else {
            return true
        }
    }
}
