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
import SwiftyJSON

class LoginController: UIViewController, UITextFieldDelegate {
    
    var ref = FIRDatabase.database().reference()
    var loginSuccess = false
    var loginView = LoginView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        loginView.loginBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        loginView.signUpBtn.addTarget(self, action: #selector(switchToSignIn), for: .touchUpInside)
        loginView.forgotPasswordBtn.addTarget(self, action: #selector(switchToForgotPassword), for: .touchUpInside)
//        MapTasks.getDirections("1225 Maryland Apt. B Albany GA", destination: "1645 Maryland Albany GA Albany GA", waypointStrings: ["1225 Maryland Apt. B Albany GA", "1208 Eager Dr. apt. A Albany GA", "1645 Maryland Albany GA"], travelMode: nil) { (str, success, route) in
//            print(route?.toDict())
//            let x = route?.toDict()
//            self.ref.child("routes").child(str).setValue(route?.toDict())
//        }

    }
    
    func clearPassField() {
        loginView.passwordTF.text = ""
    }
    
    func configureView() {
        configureButtons()
        self.view.addSubview(loginView)
        
        
    }
    
    override func viewDidLoad() {

        configureView()
        self.dismissKeyboardAtTap()
        self.loginView.emailTF.delegate = self
        self.loginView.passwordTF.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        clearPassField()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        
    }
    
    
    
    
    func textFieldShouldReturn(_:UITextField) -> Bool{
        if(loginView.emailTF.isEditing){
            loginView.passwordTF.becomeFirstResponder()
            return true
        }
        else if loginView.passwordTF.isEditing{
            loginView.passwordTF.resignFirstResponder()
            buttonAction()
            return true
        }
        //loginView.passwordTF.becomeFirstResponder()
        //return true
        return false
    }
    
    func buttonAction(){

        SwiftLoader.show(title: "Signing in", animated: true)
        //let animateBtn: UIButton = sender
        FIRAuth.auth()?.signIn(withEmail: loginView.emailTF.text!, password: loginView.passwordTF.text!) { (user, error) in
            if error == nil {
                User.setCurrentUser()
                self.ref.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        let json_snapshot = JSON(snapshot.value as! NSDictionary)
                        User.currentUser?.name = json_snapshot["name"].stringValue
                        User.currentUser?.access_code = json_snapshot["access_code"].stringValue
                    } else {
                        SwiftLoader.hide()
                        self.present(MainViewController(), animated: true, completion: {
                        })
                    }
                    
                                      }) { (error) in
                    print(error.localizedDescription)
                    SwiftLoader.hide()
                }
                self.ref.child("routes").observeSingleEvent(of: .value, with: {(snapshot) in
                    let response = JSON(snapshot.value as! NSDictionary)
                    for (_ , subJson) in response {
                        if subJson["access_code"].stringValue == User.currentUser?.access_code {
                            User.currentUser!.routes.append(Path(dict: subJson))
                        }
                    }
                    User.currentUser?.route = User.currentUser?.routes.first
                    SwiftLoader.hide()
                    self.present(MainViewController(), animated: true, completion: {
                    })
                    
                })
                
            } else {
                SwiftLoader.hide()
                let signInAlert = UIAlertController(title: "Failed Sign In", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                signInAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
                self.present(signInAlert, animated: true, completion: nil)
            }
        }
        
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


