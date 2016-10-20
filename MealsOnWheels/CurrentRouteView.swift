//
//  CurrentRouteView.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import GoogleMaps
import UIKit

class CurrentRouteView: UIView {
    
    //Map View
    var mapView : GMSMapView!
    
    //Labels
    var pathTitleLbl = UILabel()
    var pathDescLbl = UILabel()
    var totalMilesLbl = UILabel()
    var estTimeLbl = UILabel()
    
    //Buttons
    var startBtn = UIButton()
    
    var route = Model.sharedInstance.routes.last!
    
    func configureMapView() {
        mapView = GMSMapView()
        let routePath = route.path.getPath()
        let bounds = GMSCoordinateBounds(path: routePath)
        let camera = mapView.camera(for: bounds, insets: UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0))
        mapView.camera = camera!
        mapView.animate(toZoom: 14.0)
        let pathPolyline = GMSPolyline(path: route.path.getPath())
        pathPolyline.map = mapView
    }
    
    func configureLabels() {
        pathTitleLbl.font = UIFont.systemFont(ofSize: 35.0)
        pathTitleLbl.text = route.path.name
        pathTitleLbl.textColor = UIColor.white
        pathTitleLbl.textAlignment = .center
        
        pathDescLbl.text = route.path.description
        pathDescLbl.textColor = UIColor.white
        pathDescLbl.textAlignment = .center
        
        totalMilesLbl.text = "Total Miles: " + String(describing: route.path.totalMiles)
        totalMilesLbl.textColor = UIColor.white
        totalMilesLbl.textAlignment = .left
        
        estTimeLbl.text = "Estimated Time: " + route.path.estimatedTime
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
        
        configureMapView()
        configureLabels()
        configureButtons()
        
        //Auto Layout
        let viewsDict = [
            "title"     :   pathTitleLbl,
            "desc"      :   pathDescLbl,
            "mapView"   :   mapView,
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
