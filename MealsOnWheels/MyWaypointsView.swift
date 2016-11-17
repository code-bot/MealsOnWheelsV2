//
//  MyWaypointsView.swift
//  MealsOnWheels
//
//  Created by Sunwoo Yim on 10/20/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation
import UIKit

class MyWaypointsView: UIView {
    
    //Table View
    var tableView = UITableView()
    
    //Buttons
    var startRouteButton = UIButton()
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.loginDarkGradient
        
        //Auto Layout
        let viewsDict = [
            "tableView":tableView,
            "startButton":startRouteButton
            ] as [String : UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-[startButton]-10-[tableView]-|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-[tableView]-|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-[startButton]-|", views: viewsDict))
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
