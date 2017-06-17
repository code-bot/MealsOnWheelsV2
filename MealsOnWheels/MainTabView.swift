//
//  MainTabView.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class MainTabView: UIView {
    
    //Buttons
    var currentRoute = UIButton()
    var myRoutes = UIButton()
    
    //Current Page
    var currentPage = Page.currentRoute {
        willSet(newPage) {
            if (newPage != currentPage) {
                switch newPage {
                case .currentRoute:
                    currentRoute.backgroundColor = MWConstants.colors.lightBackground
                    myRoutes.backgroundColor = MWConstants.colors.darkBackground
                    break
                case .myRoutes:
                    myRoutes.backgroundColor = MWConstants.colors.lightBackground
                    currentRoute.backgroundColor = MWConstants.colors.loginDarkGradient
                    break
                }
            }
        }
    }
    
    func configureButtons() {
        currentRoute.setTitle("Current Route", for: .normal)
        currentRoute.setTitleColor(UIColor.white, for: .normal)
        currentRoute.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15.0)
        currentRoute.backgroundColor = MWConstants.colors.lightBackground
        
        myRoutes.setTitle("My Routes", for: .normal)
        myRoutes.setTitleColor(UIColor.white, for: .normal)
        myRoutes.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15.0)
        myRoutes.backgroundColor = MWConstants.colors.darkBackground
    }
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.loginBackground
        
        configureButtons()
        
        //Auto Layout
        let viewsDict = [
            "currBtn"  :   currentRoute,
            "myRoutBtn"  :   myRoutes
        ]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|[currBtn]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|[myRoutBtn]|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[currBtn(==\(String(describing: MWConstants.screenWidth/2)))]-[myRoutBtn(==\(String(describing: MWConstants.screenWidth/2)))]|", views: viewsDict))
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum Page {
    case currentRoute
    case myRoutes
}
