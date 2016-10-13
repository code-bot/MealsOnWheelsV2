//
//  RegistrationView.swift
//  MealsOnWheels
//
//  Created by Taabish Kathawala on 9/29/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class RegistrationView: UIView {
    
    
    //Text fields
    var emailTF = UITextField()
    var passTF = UITextField()
    var passConfirmTF = UITextField()
    
    //Buttons
    var nextButton = UIButton()
    
    //Label
    var welLabel = UILabel()
    
    func configureTextFields() {
        emailTF.placeholder = "  Email Address"
        passConfirmTF.placeholder = "  Confirm Password"
        passTF.placeholder = "  Password"
        
        emailTF.font = UIFont(name: "Avenir-Medium", size: 13.0)
        passTF.font = UIFont(name: "Avenir-Medium", size: 13.0)
        passConfirmTF.font = UIFont(name: "Avenir-Medium", size: 13.0)
        
        emailTF.textColor = UIColor.lightText
        passTF.textColor = UIColor.lightText
        passConfirmTF.textColor = UIColor.lightText
        
        emailTF.backgroundColor = UIColor.white
        emailTF.alpha = 0.5
        passTF.backgroundColor = UIColor.white
        passTF.alpha = 0.5
        passConfirmTF.backgroundColor = UIColor.white
        passConfirmTF.alpha = 0.5
        
        passTF.isSecureTextEntry = true
        passConfirmTF.isSecureTextEntry = true
        
        emailTF.layer.borderColor = UIColor.lightGray.cgColor
        emailTF.layer.borderWidth = 1.5
        emailTF.layer.cornerRadius = 8.0
        passTF.layer.borderColor = UIColor.lightGray.cgColor
        passTF.layer.borderWidth = 1.5
        passTF.layer.cornerRadius = 8.0
        passConfirmTF.layer.borderColor = UIColor.lightGray.cgColor
        passConfirmTF.layer.borderWidth = 1.5
        passConfirmTF.layer.cornerRadius = 8.0
        
    }

    func configureButtons() {
        nextButton.backgroundColor = UIColor.init(r: 52, g: 152, b: 219, a: 1.0)
        nextButton.setTitle("Next", for: UIControlState())
        nextButton.setTitleColor(UIColor.lightText, for: UIControlState())
        nextButton.layer.cornerRadius = 5.0
//        nextButton.layer.borderColor = UIColor.white.cgColor
//        nextButton.layer.borderWidth = 0.5
        
    }
    
    func configureLabel() {
        welLabel.text = "Sign Up"
        welLabel.font = UIFont(name: "Avenir-Medium", size: 25.0)
        welLabel.textColor = UIColor.white
        
        
    }
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.loginLightGradient
        
        
        configureButtons()
        configureLabel()
        
        
        configureTextFields()
        
        //Auto Layout
        let viewsDict = [
            "welLabel"  :   welLabel,
            "emailTF"   :   emailTF,
            "passTF"    :   passTF,
            "confirmTF" :   passConfirmTF,
            "nextBut"   :   nextButton
        ] as [String : Any]
        
        self.prepareViewsForAutoLayout(viewsDict as! [String : UIView])
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-50-[welLabel]-35-[emailTF]-25-[passTF]-25-[confirmTF]-100-[nextBut]", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[welLabel]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[emailTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[passTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[confirmTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[nextBut]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
}
