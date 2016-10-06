//
//  MainView.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class MainView: UIView {
    
    //Views
    var tabView = MainTabView()
    var navBar = MainNavBar()
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.lightBackground
        
        //Auto Layout
        let viewsDict = [
            "navBar"    :   navBar,
            "tabView"   :   tabView
        ] as [String : UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-20-[navBar(==\(String(describing: MWConstants.navBarHeight)))]", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:[tabView(==\(String(describing: MWConstants.tabBtnHeight)))]|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[navBar]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[tabView]|", views: viewsDict))
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
