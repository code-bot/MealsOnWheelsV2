//
//  MainNavBar.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 10/6/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation
import UIKit

class MainNavBar: UIView {
    
    //Buttons
    var signOutBtn = UIButton()
    var profileBtn = UIButton()
    
    func configureButtons() {
        signOutBtn.setTitle("Sign Out", for: .normal)
        signOutBtn.setTitleColor(UIColor.white, for: .normal)
        signOutBtn.backgroundColor = UIColor.clear
        
        profileBtn.setTitle("Profile", for: .normal)
        profileBtn.setTitleColor(UIColor.white, for: .normal)
        profileBtn.backgroundColor = UIColor.clear
    }
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.lightBackground
        
        configureButtons()
        
        let viewsDict = [
            "signOut"   :   signOutBtn,
            "profile"   :   profileBtn
        ] as [String: UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|[signOut]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|[profile]|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-15-[signOut]", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:[profile]-15-|", views: viewsDict))
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
