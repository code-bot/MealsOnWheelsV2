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
    var showDirBtn = UIButton()
    var phoneNumBtn = UIButton()
    
    var currWaypoint = User.currentUser!.routes.first!.path.waypoints.first
    
    func configureStreetView() {
        if let waypoint = currWaypoint {
            streetView = GMSPanoramaView(frame: .zero)
            print("LATITUDE")
            print(CLLocationDegrees(waypoint.latitude))
            print("LONGITUDE")
            print(CLLocationDegrees(waypoint.longitude))
            streetView.moveNearCoordinate(CLLocationCoordinate2D(latitude: CLLocationDegrees(waypoint.latitude), longitude: CLLocationDegrees(waypoint.longitude)))
        }
    }
    
    func configureLabels() {
        if let waypoint = currWaypoint {
            waypointTitleLbl.font = UIFont.systemFont(ofSize: 25.0)
            waypointTitleLbl.numberOfLines = 0
            let address = waypoint.title.characters.split{$0 == ","}.map(String.init)
            waypointTitleLbl.text = address[0] + ",\n" + address[1] + "," + address[2]
            waypointTitleLbl.textColor = UIColor.white
            waypointTitleLbl.textAlignment = .center
            
            waypointInfoLbl.text = "Info:" + waypoint.info
            waypointInfoLbl.textColor = UIColor.white
            waypointInfoLbl.textAlignment = .left
            
            waypointPhNumLbl.text = "Phone#:"
            waypointPhNumLbl.textColor = UIColor.white
            waypointPhNumLbl.textAlignment = .left
        }
    }
    
    func configureButtons() {
        if let waypoint = currWaypoint {
            nextBtn.setTitle("Next Point", for: .normal)
            nextBtn.setTitleColor(MWConstants.colors.darkBackground, for: .normal)
            nextBtn.backgroundColor = UIColor.white
            nextBtn.layer.cornerRadius = 20.0
            nextBtn.layer.borderColor = MWConstants.colors.lightBackground.cgColor
            nextBtn.layer.borderWidth = 2
            
            showDirBtn.setTitle("Show Directions", for: .normal)
            showDirBtn.setTitleColor(MWConstants.colors.darkBackground, for: .normal)
            showDirBtn.backgroundColor = UIColor.white
            showDirBtn.layer.cornerRadius = 20.0
            showDirBtn.layer.borderColor = MWConstants.colors.lightBackground.cgColor
            showDirBtn.layer.borderWidth = 2
            
            phoneNumBtn.setTitle("7327623380", for: .normal)
            phoneNumBtn.setTitleColor(UIColor.white, for: .normal)
            phoneNumBtn.backgroundColor = UIColor.clear
            phoneNumBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        }
    }
    
    func configureView() {
        if let _ = currWaypoint {
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
                "phoneBtn"  :   phoneNumBtn,
                "next"      :   nextBtn,
                "show"      :   showDirBtn
                ] as [String : UIView]
            
            self.prepareViewsForAutoLayout(viewsDict)
            
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-20-[title]-20-[streetView(==\(String(describing: MWConstants.streetViewHeight)))]-20-[info]-15-[phone]", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-20-[title]-20-[streetView(==\(String(describing: MWConstants.streetViewHeight)))]-20-[info]-10-[phoneBtn]", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:[streetView(==\(String(describing: MWConstants.streetViewHeight)))]-20-[next(==\(String(describing: MWConstants.startBtnHeight * 2/3)))]-10-[show(==\(String(describing: MWConstants.startBtnHeight * 2/3)))]", views: viewsDict))
            
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[title]|", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[streetView]|", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-20-[info]", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-20-[phone]-10-[phoneBtn]", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:[next(==\(String(describing: MWConstants.startBtnWidth)))]-20-|", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:[show(==\(String(describing: MWConstants.startBtnWidth)))]-20-|", views: viewsDict))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
