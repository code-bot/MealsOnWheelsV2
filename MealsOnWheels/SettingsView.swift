//
//  SettingsView.swift
//  MealsOnWheels
//
//  Created by Sunwoo Yim on 11/17/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation
import UIKit

class SettingsView: UIView {
    
    var profileImgView = UIImageView()
    var nameLabel = UILabel()
    var phoneNumberLabel = UILabel()
    var emailLabel = UILabel()
    var passwordLabel = UILabel()
    var signoutBtn = UIButton()
    
    //Views
    var navBar = MainNavBar()
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.lightBackground
        
        //Auto Layout
        let viewsDict = [
            "navBar": navBar,
            "photo": profileImgView,
            "name": nameLabel,
            "phoneNum": phoneNumberLabel,
            "email": emailLabel,
            "password": passwordLabel,
            "signout": signoutBtn
            ] as [String : UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-20-[navBar(==\(String(describing: MWConstants.navBarHeight)))]", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[navBar]|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-40-[photo(==100)]-40-[name]-25-[phoneNum]-50-[signout]", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.imageFieldsOffset))-[photo(==100)]-\(String(describing: MWConstants.imageFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[name]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[phoneNum]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-\(String(describing: MWConstants.loginFieldsOffset))-[signout]-\(String(describing: MWConstants.loginFieldsOffset))-|", views: viewsDict as [String : AnyObject]))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
