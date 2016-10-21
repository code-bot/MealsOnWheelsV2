import Foundation
import UIKit

class ForgotPasswordView: UIView {
    
    //Image Views
    var logoImgView = UIImageView()
    
    //Text Fields
    var emailTF = UITextField()
    
    //Buttons
    var submitBtn = UIButton()
    
    
    func configureImageViews() {
        logoImgView.image = MWConstants.titleImg
        logoImgView.contentMode = .scaleAspectFit
    }
    
    func configureTextFields() {
        // Setting text field item properties
        emailTF.layer.cornerRadius = 10.0
        //emailTF.layer.borderWidth = 1
        
        
        // Setting text properties
        
        emailTF.placeholder = " Email"
        emailTF.font = UIFont(name: "Avenir-Medium", size: 18.0)
        emailTF.textColor = UIColor.white
        //emailTF.textAlignment = NSTextAlignment.center
        
        
        
    }
    
    
    func textFieldDidBeginEditing(_ textField : UITextField)
    {
        emailTF.autocorrectionType = .no
        emailTF.autocapitalizationType = .none
        emailTF.spellCheckingType = .no
    }
    
    func configureButtons() {
        
        
        submitBtn.setTitle("Submit", for: UIControlState())
        submitBtn.setTitleColor(UIColor.darkText, for: UIControlState())
        submitBtn.backgroundColor = UIColor.white
        submitBtn.layer.cornerRadius = 20.0
        submitBtn.layer.borderColor = UIColor.white.cgColor
        submitBtn.layer.borderWidth = 1
        
        
        
        
        
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
            "submit" :   submitBtn
            ] as [String : UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-40-[title]-100-[emTF]-40-[submit]-200-|", views: viewsDict))
        //
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[title]|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[emTF]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[submit]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}