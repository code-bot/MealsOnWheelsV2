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
    var leftBtn = UIButton()
    var rightBtn = UIButton()
    
    func configureButtons() {
        //changes text to "Back" in MainViewController when the user clicks on specific route in MyRoutes
        leftBtn.setTitle("", for: .normal)
        leftBtn.setTitleColor(UIColor.white, for: .normal)
        leftBtn.backgroundColor = UIColor.clear
        
        rightBtn.setTitle("Sign Out", for: .normal)
        rightBtn.setTitleColor(UIColor.white, for: .normal)
        rightBtn.backgroundColor = UIColor.clear
    }
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.lightBackground
        
        configureButtons()
        
        let viewsDict = [
            "leftBtn"   :   leftBtn,
            "rightBtn"   :   rightBtn
        ] as [String: UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|[leftBtn]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|[rightBtn]|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-15-[leftBtn]", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:[rightBtn]-15-|", views: viewsDict))
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
