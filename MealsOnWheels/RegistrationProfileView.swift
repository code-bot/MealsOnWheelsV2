//
//  RegistrationProfileView.swift
//  MealsOnWheels
//
//  Created by Taabish Kathawala on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class RegistrationProfileView: UIView {
    
    // Image View
    
    //var photoImg = UIImageView()
    
    //Text fields
    var firstNameTF = UITextField()
    var lastNameTF = UITextField()
    var phoneNumberTF = UITextField()
    
    //Labels
    var firstNameLabel = UILabel()
    var lastNameLabel = UILabel()
    var phoneNumberLabel = UILabel()
    
    //Buttons
    var photoimageBtn = UIButton()
    var signUpBtn = UIButton()
    
    func configureImageView() {
       // photoImg.image = #imageLiteral(resourceName: "usericon")
        //photoImg.backgroundColor = UIColor.lightGray
        
    }
    
    func configureTextFields() {
        firstNameTF.layer.cornerRadius = 8.0
        lastNameTF.layer.cornerRadius = 8.0
        phoneNumberTF.layer.cornerRadius = 8.0
//        firstNameTF.layer.borderWidth = 1.5
//        firstNameTF.layer.borderColor = UIColor.lightGray.cgColor
//        lastNameTF.layer.borderWidth = 1.5
//        lastNameTF.layer.borderColor = UIColor.lightGray.cgColor
//        phoneNumberTF.layer.borderWidth = 1.5
//        phoneNumberTF.layer.borderColor = UIColor.lightGray.cgColor
    
        firstNameTF.placeholder = "First Name"
        lastNameTF.placeholder = "Last Name"
        phoneNumberTF.placeholder = "Phone Number"
        
        firstNameTF.font = UIFont(name: "Avenir-Medium", size: 15.0)
        lastNameTF.font = UIFont(name: "Avenir-Medium", size: 15.0)
        phoneNumberTF.font = UIFont(name: "Avenir-Medium", size: 15.0)
        
        firstNameTF.textAlignment = NSTextAlignment.natural
        lastNameTF.textAlignment = NSTextAlignment.justified
        phoneNumberTF.textAlignment = NSTextAlignment.center
        
        firstNameTF.textColor = UIColor.darkText
        lastNameTF.textColor = UIColor.darkText
        phoneNumberTF.textColor = UIColor.darkText
        
    }
    
    func configureLabels() {
        firstNameLabel.textColor = UIColor.white
        lastNameLabel.textColor = UIColor.white
        phoneNumberLabel.textColor = UIColor.white
    
        firstNameLabel.text = firstNameLabel.setUnderline()
        lastNameLabel.text = lastNameLabel.setUnderline()
        phoneNumberLabel.text = phoneNumberLabel.setUnderline()
    }
    
    
    func configureButtons() {
        photoimageBtn.backgroundColor = MWConstants.colors.lightBackground
        photoimageBtn.setImage(#imageLiteral(resourceName: "usericon"), for: .normal)
        //photoimageBtn.layer.cornerRadius = 35.0
        
        signUpBtn.setTitle("Sign Up", for: UIControlState())
        signUpBtn.setTitleColor(UIColor.white, for: UIControlState())
        signUpBtn.layer.cornerRadius = 5.0
        signUpBtn.layer.borderColor = UIColor.white.cgColor
        signUpBtn.layer.borderWidth = 0.5
        signUpBtn.backgroundColor = UIColor.white
        
        
    }
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.loginLightGradient
        configureButtons()
        configureTextFields()
        configureLabels()
        
        let viewsDict = [
            "photo"     :   photoimageBtn,
            "firstName" :   firstNameTF,
            "firstLine" :   firstNameLabel,
            "lastName"  :   lastNameTF,
            "lastLine"  :   lastNameLabel,
            "phoneNum"  :   phoneNumberTF,
            "phoneLine" :   phoneNumberLabel,
            "signup"    :   signUpBtn,
        ] as [String:Any]
        
        self.prepareViewsForAutoLayout(viewsDict as! [String : UIView])
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-10-[photo]-35-[firstName]-1-[firstLine]-24-[lastName]-1-[lastLine]-24-[phoneNum]-1-[phoneLine]-49-[signup]", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[photo]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[firstName]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[firstLine]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[lastName]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[lastLine]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[phoneNum]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[phoneLine]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[signup]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
}
