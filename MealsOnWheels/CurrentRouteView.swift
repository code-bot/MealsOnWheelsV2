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
    var estTimeLbl = UILabel()
    
    //Buttons
    var startBtn = UIButton()
    
    var route = Model.sharedInstance.routes.first!
    
    func configureImageViews() {
        mapImage.image = MWConstants.noImg
        mapImage.contentMode = .scaleAspectFill
        mapImage.clipsToBounds = true
    }
    
    func configureLabels() {
        routeTitleLbl.font = UIFont.systemFont(ofSize: 35.0)
        routeTitleLbl.text = route.name
        routeTitleLbl.textColor = UIColor.white
        routeTitleLbl.textAlignment = .center
        
        routeDescLbl.text = route.description
        routeDescLbl.textColor = UIColor.white
        routeDescLbl.textAlignment = .center
        
        totalMilesLbl.text = "Total Miles: " + String(describing: route.totalMiles)
        totalMilesLbl.textColor = UIColor.white
        totalMilesLbl.textAlignment = .left
        
        estTimeLbl.text = "Estimated Time: " + route.estimatedTime
        estTimeLbl.textColor = UIColor.white
        estTimeLbl.textAlignment = .left
    }
    
    func configureButtons() {
        startBtn.setTitle("Start Route", for: .normal)
        startBtn.setTitleColor(MWConstants.colors.darkBackground, for: .normal)
        startBtn.backgroundColor = UIColor.white
        startBtn.layer.cornerRadius = 20.0
        startBtn.layer.borderColor = MWConstants.colors.lightBackground.cgColor
        startBtn.layer.borderWidth = 2
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
            "mapView"   :   mapImage,
            "miles"     :   totalMilesLbl,
            "time"      :   estTimeLbl,
            "start"     :   startBtn
        ] as [String : UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-20-[title]-10-[desc]-20-[mapView(==\(String(describing: MWConstants.mapViewHeight)))]-20-[miles]-15-[time]", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:[mapView(==\(String(describing: MWConstants.mapViewHeight)))]-20-[start(==\(String(describing: MWConstants.startBtnHeight)))]", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[title]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[desc]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[mapView]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-20-[miles]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-20-[time]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:[start(==\(String(describing: MWConstants.startBtnWidth)))]-20-|", views: viewsDict))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
