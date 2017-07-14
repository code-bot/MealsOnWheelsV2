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
    
    //logo
    
    var logoImgView = UIImageView()
    
    
    //Text fields
    var emailTF = UITextField()
    var emailUnderlineLabel = UILabel()
    var accessCodeTF = UITextField()
    var accessCodeUnderlineLabel = UILabel()
    var passTF = UITextField()
    var passUnderlineLabel = UILabel()
    var passConfirmTF = UITextField()
    var confirmUnderlineLabel = UILabel()
    
    //Buttons
    var nextButton = UIButton()
    //var backButton = UIButton()
    
    //Label
    
    
    func configureImageView(){
    logoImgView.image = MWConstants.logo
    logoImgView.contentMode = .scaleAspectFit
    
    
    }
    
    func configureTextFields() {
        
        //emailTF.becomeFirstResponder()
    
        emailTF.attributedPlaceholder = NSAttributedString(string: "Enter Email", attributes: [NSForegroundColorAttributeName: UIColor.lightText])
        accessCodeTF.attributedPlaceholder = NSAttributedString(string: "Enter Access Code", attributes: [NSForegroundColorAttributeName: UIColor.lightText])
        passTF.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes: [NSForegroundColorAttributeName: UIColor.lightText])

        passConfirmTF.attributedPlaceholder = NSAttributedString(string: "Re-enter Password", attributes: [NSForegroundColorAttributeName:UIColor.lightText])
        
        emailTF.font = UIFont(name: "Avenir-Medium", size: 15.0)
        accessCodeTF.font = UIFont(name: "Avenir-Medium", size: 15.0)
        passTF.font = UIFont(name: "Avenir-Medium", size: 15.0)
        passConfirmTF.font = UIFont(name: "Avenir-Medium", size: 15.0)
        
        emailTF.keyboardType = UIKeyboardType.emailAddress
        emailTF.returnKeyType = UIReturnKeyType.continue
        emailTF.textColor = UIColor.white
        
        accessCodeTF.keyboardType = UIKeyboardType.alphabet
        accessCodeTF.returnKeyType = UIReturnKeyType.continue
        accessCodeTF.textColor = UIColor.white
        
        
        passTF.returnKeyType = UIReturnKeyType.continue
        passTF.textColor = UIColor.white
        passConfirmTF.textColor = UIColor.white
        
        passConfirmTF.returnKeyType = UIReturnKeyType.done
        passTF.isSecureTextEntry = true
        passConfirmTF.isSecureTextEntry = true
        
        emailTF.layer.cornerRadius = 8.0
        accessCodeTF.layer.cornerRadius = 8.0
        passTF.layer.cornerRadius = 8.0
        passConfirmTF.layer.cornerRadius = 8.0
        
    }
    
    func configureLabels(){
        emailUnderlineLabel.textColor = UIColor.white
        accessCodeUnderlineLabel.textColor = UIColor.white
        passUnderlineLabel.textColor = UIColor.white
        confirmUnderlineLabel.textColor = UIColor.white
        
        emailUnderlineLabel.text = emailUnderlineLabel.setUnderline()
        accessCodeUnderlineLabel.text = accessCodeUnderlineLabel.setUnderline()
        passUnderlineLabel.text = passUnderlineLabel.setUnderline()
        confirmUnderlineLabel.text = confirmUnderlineLabel.setUnderline()
        
    }
    func textFieldDidBeginEditing(_ textField : UITextField)
    {
        emailTF.autocorrectionType = .no
        emailTF.autocapitalizationType = .none
        emailTF.spellCheckingType = .no
        
    }
    
    func configureButtons() {
        //nextButton.backgroundColor = UIColor.init(r: 52, g: 152, b: 219, a: 1.0)
        nextButton.backgroundColor = UIColor.clear
        nextButton.setTitle("Next", for: UIControlState())
        nextButton.setTitleColor(UIColor.white, for: UIControlState())
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.borderColor = UIColor.lightText.cgColor
        nextButton.layer.borderWidth = 1.0
        
        //backButton.setTitle("   Back", for: UIControlState())
        //backButton.setTitleColor(UIColor.white, for: UIControlState())
        //backButton.backgroundColor = UIColor.white
        
        
        
        
    }

    
    func configureView() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [MWConstants.colors.loginDarkGradient.cgColor, MWConstants.colors.loginLightGradient.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
        
        
        configureImageView()
        configureButtons()
        configureLabels()
        configureTextFields()
        textFieldDidBeginEditing(emailTF)
        textFieldDidBeginEditing(accessCodeTF)
        textFieldDidBeginEditing(passTF)
        textFieldDidBeginEditing(passConfirmTF)
        //Auto Layout
        let viewsDict = [
            "logo"      :   logoImgView,
            //"back"          :   backButton,
            "emailTF"       :   emailTF,
            "emailLine"     :   emailUnderlineLabel,
            "accessCodeTF"  :   accessCodeTF,
            "accessCodeLine": accessCodeUnderlineLabel,
            "passTF"        :   passTF,
            "passLine"      :   passUnderlineLabel,
            "confirmTF"     :   passConfirmTF,
            "confirmLine"   :   confirmUnderlineLabel,
            "nextBut"       :   nextButton
        ] as [String : Any]
        
        self.prepareViewsForAutoLayout(viewsDict as! [String : UIView])
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-30-[logo]-60-[emailTF]-1-[emailLine]-24-[accessCodeTF]-1-[accessCodeLine]-24-[passTF]-1-[passLine]-24-[confirmTF]-1-[confirmLine]-49-[nextBut]", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[logo]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        //self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-20-[back]-80-[welLabel]", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[emailTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[emailLine]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[accessCodeTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[accessCodeLine]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[passTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[passLine]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[confirmTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[confirmLine]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
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
