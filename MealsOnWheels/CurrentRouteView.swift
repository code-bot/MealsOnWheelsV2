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
    
    var currRoute = User.routes.last
    
    func configureMapView() {
        if let route = currRoute {
            mapView = GMSMapView()
            let routePath = route.path.getPath()
            let bounds = GMSCoordinateBounds(path: routePath)
            let camera = mapView.camera(for: bounds, insets: UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0))
            mapView.camera = camera!
            mapView.animate(toZoom: 14.0)
            let pathPolyline = GMSPolyline(path: route.path.getPath())
            pathPolyline.strokeWidth = 5.0
            pathPolyline.map = mapView
        }
    }
    
    func configureLabels() {
        if let route = currRoute {
            pathTitleLbl.font = UIFont.systemFont(ofSize: 30.0)
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
        } else {
            pathTitleLbl.font = UIFont.systemFont(ofSize: 30.0)
            pathTitleLbl.text = "No Available Routes"
            pathTitleLbl.textColor = UIColor.white
            pathTitleLbl.textAlignment = .center
            
            pathDescLbl.text = "Go to My Routes page to add a route"
            pathDescLbl.textColor = UIColor.white
            pathDescLbl.textAlignment = .center
        }
    }
    
    func configureButtons() {
        if let _ = currRoute {
            startBtn.setTitle("Start Route", for: .normal)
            startBtn.setTitleColor(MWConstants.colors.darkBackground, for: .normal)
            startBtn.backgroundColor = UIColor.white
            startBtn.layer.cornerRadius = 20.0
            startBtn.layer.borderColor = MWConstants.colors.lightBackground.cgColor
            startBtn.layer.borderWidth = 2
        }
    }
    
    func configureView() {
        if let _ = currRoute {
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
            
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:[title]-10-[desc]-10-[mapView(==\(String(describing: MWConstants.mapViewHeight)))]-15-[miles]-15-[time]-15-|", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:[mapView(==\(String(describing: MWConstants.mapViewHeight)))]-15-[start(==\(String(describing: MWConstants.startBtnHeight)))]-15-|", views: viewsDict))
            
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[title]|", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[desc]|", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[mapView]|", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-20-[miles]|", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|-20-[time]|", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:[start(==\(String(describing: MWConstants.startBtnWidth)))]-20-|", views: viewsDict))
        } else {
            self.backgroundColor = MWConstants.colors.darkBackground
            configureLabels()
            
            //Auto Layout
            let viewsDict = [
                "title"     :   pathTitleLbl,
                "desc"      :   pathDescLbl
                ] as [String : UIView]
            
            self.prepareViewsForAutoLayout(viewsDict)
            
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("V:|-15[title]-10-[desc]", views: viewsDict))
            
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[title]|", views: viewsDict))
            self.addConstraints(NSLayoutConstraint.constraintsWithSimpleFormat("H:|[desc]|", views: viewsDict))
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
