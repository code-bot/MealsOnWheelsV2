//
//  CurrentRouteView.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import UIKit

class CurrentRouteView: UIView {
    
    //Image Views
    var mapImage = UIImageView()
    
    //Labels
    var routeTitleLbl = UILabel()
    var routeDescLbl = UILabel()
    var totalMilesLbl = UILabel()
    
    //Buttons
    var startRoute = UIButton()
    
    var route = Model.sharedInstance.routes.first!
    
    func configureImageViews() {
        mapImage.image = MWConstants.noImg
        mapImage.contentMode = .scaleAspectFill
        mapImage.clipsToBounds = true
    }
    
    func configureLabels() {
        routeTitleLbl.text = route.name
        routeTitleLbl.textColor = UIColor.white
        routeTitleLbl.textAlignment = .center
        
        routeDescLbl.text = route.description
        routeDescLbl.textColor = UIColor.white
        routeDescLbl.textAlignment = .center
    }
    
    func configureButtons() {
//        loginBtn.setTitle("Login", for: .normal)
//        loginBtn.setTitleColor(UIColor.white, for: .normal)
//        loginBtn.backgroundColor = UIColor.clear
//        
//        signUpBtn.setTitle("Sign Up", for: .normal)
//        signUpBtn.setTitleColor(UIColor.white, for: .normal)
//        signUpBtn.backgroundColor = UIColor.clear
    }
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.darkBackground
        
        configureImageViews()
        configureLabels()
        configureButtons()
        
        //Auto Layout
        let viewsDict = [
            "title"     :   routeTitleLbl,
            "desc"      :   routeDescLbl,
            "mapView"   :   mapImage
        ] as [String : UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-20-[title]-10-[desc]-20-[mapView]", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[title]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[desc]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[mapView]|", views: viewsDict))
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
