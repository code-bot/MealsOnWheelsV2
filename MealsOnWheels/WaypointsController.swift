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

class WaypointsController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var mainViewController: MainViewController!
    var route: Route!
    let myWaypointsView = MyWaypointsView(frame: CGRect(x: 0, y: MWConstants.navBarHeight + 20.0, width: MWConstants.screenWidth, height: MWConstants.screenHeight - MWConstants.tabBtnHeight - MWConstants.navBarHeight - 20.0))
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return route.path.waypoints.count+1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = myWaypointsView.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        if (indexPath.row == route.path.waypoints.count) {
            //+ new route
            cell.textLabel?.textAlignment = NSTextAlignment.center
            cell.textLabel?.text = "+"
            return cell
        }
        let waypoint:Waypoint = route.path.waypoints[indexPath.row]
        cell.textLabel?.text = waypoint.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == route.path.waypoints.count) {
            //add new route
            mainViewController.addNew(type: "Waypoint", index: indexPath.row)
            return
        }
        //see information for each waypoint
        //TODO
    }
}
