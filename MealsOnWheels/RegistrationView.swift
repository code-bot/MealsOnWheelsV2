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
    var backButton = UIButton()
    
    //Label
    var welLabel = UILabel()
    
    func configureTextFields() {
        emailTF.placeholder = "  Email Address"
        passConfirmTF.placeholder = "  Confirm Password"
        passTF.placeholder = "  Password"
        
        emailTF.font = UIFont(name: "Avenir-Medium", size: 18.0)
        passTF.font = UIFont(name: "Avenir-Medium", size: 18.0)
        passConfirmTF.font = UIFont(name: "Avenir-Medium", size: 18.0)

        
        emailTF.backgroundColor = UIColor.clear
        emailTF.alpha = 0.5
        passTF.backgroundColor = UIColor.clear
        passTF.alpha = 0.5
        passConfirmTF.backgroundColor = UIColor.clear
        passConfirmTF.alpha = 0.5
        
        emailTF.textColor = UIColor.darkText
        passTF.textColor = UIColor.darkText
        passConfirmTF.textColor = UIColor.darkText
        
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
    
    func textFieldDidBeginEditing(_ textField : UITextField)
    {
        emailTF.autocorrectionType = .no
        emailTF.autocapitalizationType = .none
        emailTF.spellCheckingType = .no
        passTF.autocorrectionType = .no
        passTF.autocapitalizationType = .none
        passTF.spellCheckingType = .no
        passConfirmTF.autocorrectionType = .no
        passConfirmTF.autocapitalizationType = .none
        passConfirmTF.spellCheckingType = .no
    }
    
    func configureButtons() {
        //nextButton.backgroundColor = UIColor.init(r: 52, g: 152, b: 219, a: 1.0)
        nextButton.backgroundColor = UIColor.white
        nextButton.setTitle("Next", for: UIControlState())
        nextButton.setTitleColor(UIColor.darkText, for: UIControlState())
        nextButton.layer.cornerRadius = 5.0
        nextButton.layer.borderColor = UIColor.white.cgColor
        nextButton.layer.borderWidth = 0.5
        
        backButton.setTitle("   Back", for: UIControlState())
        backButton.setTitleColor(UIColor.white, for: UIControlState())
        //backButton.backgroundColor = UIColor.white
        
        
        
        
    }
    
    func configureLabel() {
        welLabel.text = "Welcome"
        welLabel.font = UIFont(name: "California-medium", size: 45.0)
        
        welLabel.textColor = UIColor.white
        welLabel.textAlignment = NSTextAlignment.center
        
        
    }
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.loginLightGradient
        
        
        
        configureLabel()
        configureButtons()
        
        configureTextFields()
        textFieldDidBeginEditing(emailTF)
        textFieldDidBeginEditing(passTF)
        textFieldDidBeginEditing(passConfirmTF)
        //Auto Layout
        let viewsDict = [
            "welLabel"  :   welLabel,
            "back"      :   backButton,
            "emailTF"   :   emailTF,
            "passTF"    :   passTF,
            "confirmTF" :   passConfirmTF,
            "nextBut"   :   nextButton
        ] as [String : Any]
        
        self.prepareViewsForAutoLayout(viewsDict as! [String : UIView])
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-50-[back][welLabel]-35-[emailTF]-25-[passTF]-25-[confirmTF]-50-[nextBut]", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[welLabel]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        //self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-20-[back]-80-[welLabel]", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[emailTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[passTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[confirmTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[nextBut]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
//        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[back]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
}
