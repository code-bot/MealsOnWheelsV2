//
//  MyRoutesView.swift
//  MealsOnWheels
//
//  Created by Sunwoo Yim on 10/6/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class MyRoutesView: UIView {
    
    //Table View
    var tableView = UITableView()
    
    //Buttons
    
    
    func configureButtons() {
        
    }
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.loginDarkGradient
        
        configureButtons()
        
        //Auto Layout
        let viewsDict = [
            "tableView":tableView
            ] as [String : UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-[tableView]-|", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-[tableView]-|", views: viewsDict))
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
