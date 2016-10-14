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
    
    func configureTextFields() {
        emailTF.placeholder = "Email Address"
        
        passTF.placeholder = "Password"
        
        passConfirmTF.placeholder = "Confirm Password"
        
        emailTF.backgroundColor = UIColor.white
        passTF.backgroundColor = UIColor.white
        passConfirmTF.backgroundColor = UIColor.white
        
    }
    
    func configureButtons() {
        nextButton.backgroundColor = UIColor.red
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.loginDarkGradient
        
        configureTextFields()
        configureButtons()
        
        
        configureTextFields()
        
        //Auto Layout
        let viewsDict = [
            "emailTF"   :   emailTF,
            "passTF"    :   passTF,
            "confirmTF" :   passConfirmTF,
            "nextBut"   :   nextButton
        ] as [String : Any]
        
        self.prepareViewsForAutoLayout(viewsDict as! [String : UIView])
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-20-[emailTF]-20-[passTF]-20-[confirmTF]-300[nextBut]", views: viewsDict as [String : AnyObject]))
        
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