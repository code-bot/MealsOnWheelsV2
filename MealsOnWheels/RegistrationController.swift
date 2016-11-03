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

class RegistrationController : UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var passConfirmTF: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var welLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var passConfirm = false
    var ref = FIRDatabase.database().reference()
    var registrationView = RegistrationView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        //registrationView.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
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
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    func confirmPasswords(sender: AnyObject) {
        SwiftLoader.show(title: "Signing Up", animated: true)
        if registrationView.passTF.text != registrationView.passConfirmTF.text {
            SwiftLoader.hide()
            let signUpAlert = UIAlertController(title: "Failed Sign Up", message: "passwords do not match", preferredStyle: UIAlertControllerStyle.alert)
            signUpAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
            self.present(signUpAlert, animated: true, completion: nil)
        } else {
            FIRAuth.auth()?.createUser(withEmail: registrationView.emailTF.text!, password: registrationView.passTF.text!) { (user, error) in
                _ = User()
                User.uid = user?.uid
                SwiftLoader.hide()
                if error == nil {
                    self.ref.child("users").child(User.uid!).child("routes").observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.exists() {
                            let routes = snapshot.value as? NSArray
                            for (route) in routes! {
                                self.ref.child("routes").child(route as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                                    SwiftLoader.hide()
                                    User.routes.append(Route(dict: JSON(snapshot.value as? NSDictionary)))
                                    User.route = User.routes.first
                                    self.present(MainViewController(), animated: true, completion: {
                                    })
                                })
                            }
                        } else {
                            //poppulate with an emty route
                        }
                        
                    }) { (error) in
                        print(error.localizedDescription)
                        SwiftLoader.hide()
                    }
                    _ = UIButton()
                    self.present(RegistrationProfileController(), animated: true, completion: nil)
                
                }
                
                else {
                    let signUpAlert = UIAlertController(title: "Failed Sign Up", message: error?.localizedDescription, preferredStyle:  UIAlertControllerStyle.alert)
                    signUpAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
                    self.present(signUpAlert, animated: true, completion: nil)
                }
            }
        }
//        SwiftLoader.show(title: "Loading...", animated: true)
//        User.init(email: emailField.text!, password: passField.text!, errorCase: {() -> Void in
//            SwiftLoader.hide()
//            let signUpAlert = UIAlertController(title: "Failed Sign Up", message: "Incorrect Email and Password", preferredStyle: UIAlertControllerStyle.alert)
//            signUpAlert
//            signUpAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
//            self.passConfirm = false
//            }, closure: {() -> Void in
//                SwiftLoader.hide()
//                self.passConfirm = true
//                self.performSegue(withIdentifier: "Sign Up", sender: self)
//            
        
            
            
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

//        })
//    }
//    override var preferredStatusBarStyle : UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent
//    }
        
    }
    
    func goBack(sender: UIButton){
        
        dismiss(animated: false, completion: nil)
        present(LoginController(), animated: true, completion: nil)
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "Sign Up") {
            return passConfirm
        } else {
            return true
        }
    }
    

}

