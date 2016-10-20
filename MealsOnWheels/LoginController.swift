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

class LoginController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signUp: UIButton!
<<<<<<< HEAD
    @IBOutlet weak var forgotPassword: UIButton!
=======
    var ref = FIRDatabase.database().reference()
    
>>>>>>> 91626dabb978a2a7d41ddda9d5f17be8d39ecf62
    
    var loginSuccess = false
    var loginView = LoginView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        loginView.loginBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        loginView.signUpBtn.addTarget(self, action: #selector(switchToSignIn), for: .touchUpInside)
<<<<<<< HEAD
        
        loginView.forgotPasswordBtn.addTarget(self, action: #selector(switchToForgotPassword), for: .touchUpInside)
        
        
        
=======
>>>>>>> 91626dabb978a2a7d41ddda9d5f17be8d39ecf62
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
<<<<<<< HEAD
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
=======
//        SwiftLoader.show(title: "Signing in", animated: true)
//        let animateBtn: UIButton = sender
//        FIRAuth.auth()?.signIn(withEmail: loginView.emailTF.text!, password: loginView.passwordTF.text!) { (user, error) in
//            SwiftLoader.hide()
//            if error == nil {
//                
//                _ = User()
//                User.uid = user?.uid
//                self.ref.child("users").child(User.uid!).child("routes").observeSingleEvent(of: .value, with: { (snapshot) in
//                    if snapshot.exists() {
//                        let routes = snapshot.value as? NSArray
//                        for (route) in routes! {
//                            self.ref.child("routes").child(route as! String).observeSingleEvent(of: .value, with: { (snapshot) in
//                                let dict = JSON(snapshot as? NSDictionary)
//                                //User.routes.append(Route(dict: JSON(snapshot.value as? NSDictionary)))
//                            })
//                        }
//                        User.route = User.routes.first
//                    }
//                    //                    commented out section is used to manually poppulate testing data
//                    
//                    //                    MapTasks.getDirections("671 10th St NW, Atlanta, GA 30318", destination: "548 Northside Dr NW, Atlanta, GA 30318", waypointStrings: ["746 Marietta St NW, Atlanta, GA 30318", "539 10th St NW, Atlanta, GA 30318", "388 Luckie St NW, Atlanta, GA 30313"], travelMode: nil) { (str, success, route) in
//                    //                        print(route?.toDict())
//                    //                        self.ref.child(user.uid).child("paths").childByAutoId().setValue(route?.toDict())
//                    //                    }
//                }) { (error) in
//                    print(error.localizedDescription)
//                }
//                self.present(MainViewController(), animated: true, completion: {
//                    
//                })
//            } else {
//                let signInAlert = UIAlertController(title: "Failed Sign In", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
//                signInAlert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.cancel,handler: nil))
//                self.present(signInAlert, animated: true, completion: nil)
//            }
//        }
//        if animateBtn.isTouchInside == true {
//            animateBtn.backgroundColor = UIColor.lightGray
//        }
    
>>>>>>> 91626dabb978a2a7d41ddda9d5f17be8d39ecf62
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
