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
                self.ref.child("users").child(user!.uid).child("routes").observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        let routes = snapshot.value as? NSArray
                        for (route) in routes! {
                            self.ref.child("routes").child(route as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                                SwiftLoader.hide()
                                User.currentUser!.routes.append(Route(dict: JSON(snapshot.value as! NSDictionary)))
                                User.currentUser!.route = User.currentUser!.routes.first
                                self.present(MainViewController(), animated: true, completion: {
                                })
                            })
                        }
                    } else {
                        SwiftLoader.hide()
                        self.present(MainViewController(), animated: true, completion: {
                        })
                    }
                    //                    commented out section is used to manually poppulate testing data
                    
                    //                    MapTasks.getDirections("671 10th St NW, Atlanta, GA 30318", destination: "548 Northside Dr NW, Atlanta, GA 30318", waypointStrings: ["746 Marietta St NW, Atlanta, GA 30318", "539 10th St NW, Atlanta, GA 30318", "388 Luckie St NW, Atlanta, GA 30313"], travelMode: nil) { (str, success, route) in
                    //                        print(route?.toDict())
                    //                        self.ref.child(user.uid).child("paths").childByAutoId().setValue(route?.toDict())
                    //                    }
                }) { (error) in
                    print(error.localizedDescription)
                    SwiftLoader.hide()
                }
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


//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
//    {
//        if (textField == registrationProfileView.phoneNumberTF)
//        {
//            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
//            let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
//
//            let decimalString = components.joined(separator: "") as NSString
//            let length = decimalString.length
//            let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
//
//            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
//            {
//                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
//
//                return (newLength > 10) ? false : true
//            }
//            var index = 0 as Int
//            let formattedString = NSMutableString()
//
//            if hasLeadingOne
//            {
//                formattedString.append("1 ")
//                index += 1
//            }
//            if (length - index) > 3
//            {
//                let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
//                formattedString.appendFormat("(%@)", areaCode)
//                index += 3
//            }
//            if length - index > 3
//            {
//                let prefix = decimalString.substring(with: NSMakeRange(index, 3))
//                formattedString.appendFormat("%@-", prefix)
//                index += 3
//            }
//
//            let remainder = decimalString.substring(from: index)
//            formattedString.append(remainder)
//            textField.text = formattedString as String
//            return false
//        }
//        else
//        {
//            return true
//        }
//    }

