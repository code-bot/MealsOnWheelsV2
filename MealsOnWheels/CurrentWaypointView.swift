//
//  CurrentWaypointView.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 10/20/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation
import GoogleMaps
import UIKit

class CurrentWaypointView: UIView {
    
    //Map View
    var streetView : GMSPanoramaView!
    
    //Labels
    var waypointTitleLbl = UILabel()
    var waypointInfoLbl = UILabel()
    var waypointPhNumLbl = UILabel()
    
    //Buttons
    var nextBtn = UIButton()
    
    var waypoint = Model.sharedInstance.routes.first!.path.waypoints.first!
    
    func configureStreetView() {
        streetView = GMSPanoramaView(frame: .zero)
        streetView.moveNearCoordinate(CLLocationCoordinate2D(latitude: CLLocationDegrees(waypoint.latitude), longitude: CLLocationDegrees(waypoint.longitude)))
        
    }
    
    func configureLabels() {
        waypointTitleLbl.font = UIFont.systemFont(ofSize: 35.0)
        waypointTitleLbl.text = waypoint.title
        waypointTitleLbl.textColor = UIColor.white
        waypointTitleLbl.textAlignment = .center
        
        waypointInfoLbl.text = waypoint.info
        waypointInfoLbl.textColor = UIColor.white
        waypointInfoLbl.textAlignment = .left
        
        waypointPhNumLbl.text = "Phone#: " + waypoint.phoneNumber
        waypointPhNumLbl.textColor = UIColor.white
        waypointPhNumLbl.textAlignment = .left
    }
    
    func configureButtons() {
        nextBtn.setTitle("Next Point", for: .normal)
        nextBtn.setTitleColor(MWConstants.colors.darkBackground, for: .normal)
        nextBtn.backgroundColor = UIColor.white
        nextBtn.layer.cornerRadius = 20.0
        nextBtn.layer.borderColor = MWConstants.colors.lightBackground.cgColor
        nextBtn.layer.borderWidth = 2
    }
    
    func configureView() {
        self.backgroundColor = MWConstants.colors.darkBackground
        
        configureStreetView()
        configureLabels()
        configureButtons()
        
        //Auto Layout
        let viewsDict = [
            "title"     :   waypointTitleLbl,
            "streetView":   streetView,
            "info"      :   waypointInfoLbl,
            "phone"     :   waypointPhNumLbl,
            "next"      :   nextBtn
            ] as [String : UIView]
        
        self.prepareViewsForAutoLayout(viewsDict)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-20-[title]-20-[streetView(==\(String(describing: MWConstants.streetViewHeight)))]-20-[info]-15-[phone]", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:[mapView(==\(String(describing: MWConstants.streetViewHeight)))]-20-[next(==\(String(describing: MWConstants.startBtnHeight)))]", views: viewsDict))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[title]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[streetView]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-20-[info]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-20-[phone]|", views: viewsDict))
        self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:[next(==\(String(describing: MWConstants.startBtnWidth)))]-20-|", views: viewsDict))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
