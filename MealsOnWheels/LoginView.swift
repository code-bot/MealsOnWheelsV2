//
//  LoginView.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    //Image Views
    var logoImgView = UIImageView()
    
    //Text Fields
    var emailTF = UITextField()
    var passwordTF = UITextField()
    
    //Buttons
    var loginBtn = UIButton()
    var signUpBtn = UIButton()
    var forgotPasswordBtn = UIButton()
    
    
    
    func configureImageViews() {
        logoImgView.image = MWConstants.titleImg
        logoImgView.contentMode = .scaleAspectFit
    }
    
    func configureTextFields() {
     // Setting text field item properties
        emailTF.layer.cornerRadius = 10.0
        emailTF.layer.borderWidth = 1
        
        passwordTF.layer.cornerRadius = 10.0
        passwordTF.layer.borderWidth = 1
        
    // Setting text properties
        
        emailTF.placeholder = " Email"
        emailTF.font = UIFont(name: "Avenir-Medium", size: 18.0)
        emailTF.textColor = UIColor.white
        //emailTF.textAlignment = NSTextAlignment.center
        
        
        passwordTF.placeholder = " Password"
        passwordTF.font = UIFont(name: "Avenir-Medium", size: 18.0)
        passwordTF.textColor = UIColor.white
        passwordTF.isSecureTextEntry = true
        //passwordTF.textAlignment = NSTextAlignment.center
        
        
    }
    
    
    func textFieldDidBeginEditing(_ textField : UITextField)
    {
        emailTF.autocorrectionType = .no
        emailTF.autocapitalizationType = .none
        emailTF.spellCheckingType = .no
    }
    
    func configureButtons() {
        
        
        loginBtn.setTitle("Login", for: UIControlState())
        loginBtn.setTitleColor(UIColor.darkText, for: UIControlState())
        loginBtn.backgroundColor = UIColor.white
        loginBtn.layer.cornerRadius = 20.0
        loginBtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.layer.borderWidth = 1
        
        
        signUpBtn.setTitle("Need to Sign Up?", for: UIControlState())
        signUpBtn.setTitleColor(UIColor.lightText, for: UIControlState())
        signUpBtn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 12.0)
        
        forgotPasswordBtn.setTitle("Forgot Password?", for: UIControlState())
        forgotPasswordBtn.setTitleColor(UIColor.lightText, for: UIControlState())
        forgotPasswordBtn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 12.0)

        
        
    }
    
    
    
    func configureView() {
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [MWConstants.colors.loginDarkGradient.cgColor, MWConstants.colors.loginLightGradient.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
        
        configureImageViews()
        configureTextFields()
        configureButtons()
        textFieldDidBeginEditing(emailTF)
        
        //Auto Layout
        let viewsDict = [
            "title"  :   logoImgView,
            "emTF"  :   emailTF,
            "psTF"  :   passwordTF,
            "login" :   loginBtn,
            "signup":   signUpBtn,
            "forgotPw": forgotPasswordBtn
            ] as [String : UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
//          self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:[title]-100-[emTF]-30-[psTF]-60-[login]-30-[signup]-|", views: viewsDict as [String : AnyObject]))
//        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-40-[title]-100-[emTF]-30-[psTF]-60-[login]-10-[forgotPw]-30-[signup]|", views: viewsDict))
//
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[title]|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[emTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
//         self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-30-[title]-30-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[psTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[login]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[signup]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
         self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[forgotPw]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
