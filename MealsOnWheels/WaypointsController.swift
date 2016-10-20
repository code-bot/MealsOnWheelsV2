//
//  WaypointsConroller.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/17/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import SwiftLoader
import UIKit

class WaypointsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var route: Route!
    let myWaypointsView = MyWaypointsView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureView() {
        self.view.addSubview(myWaypointsView)
    }
    
    override func viewDidLoad() {
        configureView()
        
        myWaypointsView.tableView.delegate = self;
        myWaypointsView.tableView.dataSource = self;
        myWaypointsView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return route.path.waypoints.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = myWaypointsView.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let waypoint:Waypoint = route.path.waypoints[indexPath.row]
        cell.textLabel?.text = waypoint.title
        return cell
    }
}
