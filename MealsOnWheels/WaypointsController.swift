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
    var selectedIndex: Int!
    
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
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50; //Set this to any value that works for you.
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        let waypoint:Waypoint = route.path.waypoints[indexPath.row]
        if (indexPath.row == selectedIndex) {
            //the cell user selected has more information
            //cell.textLabel?.text = "\(waypoint.title!)\t\(waypoint.phoneNumber!)\n\(waypoint.info!)"
            cell.textLabel?.text = "\(waypoint.title!)\n337339204\nthis guy is dead dont go to him"
        } else {
            //every other cell
            cell.textLabel?.text = waypoint.title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == route.path.waypoints.count) {
            //add new route
            mainViewController.addNew(type: "Waypoint", index: indexPath.row, tableView: tableView)
            return
        }
        //see information for each waypoint
        if (selectedIndex == indexPath.row) {
            //minimize
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //edit the information
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit" , handler: { (action:UITableViewRowAction!, indexPath:IndexPath!) -> Void in
            //popup with the information to edit
            let alertController = UIAlertController(title: "Edit Waypoint", message: self.route.path.waypoints[indexPath.row].title, preferredStyle: .alert)
            let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
                let phoneTF = alertController.textFields![0] as UITextField
                self.route.path.waypoints[indexPath.row].phoneNumber = phoneTF.text!
                tableView.reloadData()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "Phone Number"
            }
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            self.mainViewController.present(alertController, animated: true);
        })
        
        //delete
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Delete" , handler: { (action:UITableViewRowAction!, indexPath:IndexPath!) -> Void in
            //delete this cell
            User.routes.remove(at: indexPath.row)
        })
        return [deleteAction, editAction]
    }
}
