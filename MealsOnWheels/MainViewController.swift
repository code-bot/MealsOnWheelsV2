//
//  MainViewConroller.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/17/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import SwiftLoader
import UIKit
import Firebase

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mainView = MainView();
    let currentRouteView = CurrentRouteView(frame: CGRect(x: 0, y: MWConstants.navBarHeight + 20.0, width: MWConstants.screenWidth, height: MWConstants.screenHeight - MWConstants.tabBtnHeight - MWConstants.navBarHeight - 20.0))
    let currentWayPointView = CurrentWaypointView(frame: CGRect(x: 0, y: MWConstants.navBarHeight + 20.0, width: MWConstants.screenWidth, height: MWConstants.screenHeight - MWConstants.tabBtnHeight - MWConstants.navBarHeight - 20.0))
    let myRoutesView = MyRoutesView(frame: CGRect(x: 0, y: MWConstants.navBarHeight + 20.0, width: MWConstants.screenWidth, height: MWConstants.screenHeight - MWConstants.tabBtnHeight - MWConstants.navBarHeight - 20.0))
    
    var currentView: UIView!
    var routeStarted = false
    let myWaypointsController = WaypointsController()
    
    func configureButtons() {
        mainView.tabView.currentRoute.addTarget(self, action: #selector(switchPage(_:)), for: .touchUpInside)
        currentRouteView.startBtn.addTarget(self, action: #selector(startRoute), for: .touchUpInside)
        currentWayPointView.nextBtn.addTarget(self, action: #selector(nextLeg), for: .touchUpInside)
        mainView.tabView.myRoutes.addTarget(self, action: #selector(switchPage(_:)), for: .touchUpInside)

        mainView.navBar.leftBtn.addTarget(self, action: #selector(backPage), for: .touchUpInside)
    }
    
    func configureView() {        
        myWaypointsController.selectedIndex = -1
        myWaypointsController.mainViewController = self
        myWaypointsController.myWaypointsView.tableView.delegate = myWaypointsController;
        myWaypointsController.myWaypointsView.tableView.dataSource = myWaypointsController;
        myWaypointsController.myWaypointsView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myWaypointsController.myWaypointsView.startRouteButton.setTitle("Start Route", for:UIControlState.normal)
        //myWaypointsController.myWaypointsView.startRouteButton.backgroundColor = UIColor.white
        //myWaypointsController.myWaypointsView.startRouteButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        myWaypointsController.myWaypointsView.startRouteButton.addTarget(myWaypointsController, action: #selector(myWaypointsController.startRoute), for: UIControlEvents.touchUpInside)
        
        configureButtons()
        currentView = currentRouteView
        mainView.addSubview(currentView)
        self.view = mainView
    }
    
    override func viewDidLoad() {
        configureView()
        myRoutesView.tableView.delegate = self;
        myRoutesView.tableView.dataSource = self;
        myRoutesView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    func startRoute() {
        routeStarted = true
        currentView = currentWayPointView
        nextLeg()
    }
    
    func backPage(sender:UIButton) {
        if (mainView.navBar.leftBtn.title(for: .normal) == "") {
            return
        }
        mainView.navBar.leftBtn.setTitle("", for: .normal)
        mainView.addSubview(myRoutesView)
        myWaypointsController.myWaypointsView.removeFromSuperview()
    }
    
    func switchPage(_ sender: UIButton) {
        mainView.navBar.leftBtn.setTitle("", for: .normal)
        if sender == mainView.tabView.currentRoute {
            mainView.tabView.currentPage = Page.currentRoute
            mainView.addSubview(currentView)
            myRoutesView.removeFromSuperview()
        } else if sender == mainView.tabView.myRoutes {
            mainView.tabView.currentPage = Page.myRoutes
            mainView.addSubview(myRoutesView)
            currentView.removeFromSuperview()
        }
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.currentUser!.routes.count+1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = myRoutesView.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        if (indexPath.row == User.currentUser!.routes.count) {
            //+ new route
            cell.textLabel?.textAlignment = NSTextAlignment.center
            cell.textLabel?.text = "+"
            return cell
        }
        let route = User.currentUser!.routes[indexPath.row];
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let convertedDate = dateFormatter.string(from: route.date as Date)
        let cellText = "\(route.path.name)\t\(convertedDate)\nUsers: \(route.user1Name) & \(route.user2Name)"
        //let cellText = "Route 1\t\(convertedDate)"
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.text = cellText
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == User.currentUser!.routes.count) {
            //add new route
            addNew(type: "Route", index: -1, tableView: tableView)
            return
        }
        //switch to waypoints view
        myWaypointsController.routeIndex = indexPath.row
        mainView.addSubview(myWaypointsController.myWaypointsView)
        myRoutesView.removeFromSuperview()
        mainView.navBar.leftBtn.setTitle("Back", for: .normal)
        //self.present(myWaypointsController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let route = User.currentUser!.routes[indexPath.row];
        //edit the information
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit" , handler: { (action:UITableViewRowAction!, indexPath:IndexPath!) -> Void in
            //popup with the information to edit
            let alertController = UIAlertController(title: "Edit Route", message: route.path.name, preferredStyle: .alert)
            let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
                let user1TF = alertController.textFields![0] as UITextField
                let user2TF = alertController.textFields![1] as UITextField
                User.currentUser!.routes[indexPath.row].user1Name = user1TF.text!
                User.currentUser!.routes[indexPath.row].user2Name = user2TF.text!
                tableView.reloadData()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "User 1"
                textField.text = User.currentUser!.routes[indexPath.row].user1Name
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "User 2"
                textField.text = User.currentUser!.routes[indexPath.row].user2Name
            }
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true);
        })
        
        //delete
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Delete" , handler: { (action:UITableViewRowAction!, indexPath:IndexPath!) -> Void in
            //delete this cell
            self.delete(type: "Route", index: indexPath.row);
        })
        return [deleteAction, editAction]
    }
    
    func nextLeg() {
        if let nextWaypoint = User.currentUser!.route?.path.nextLeg() {
            currentWayPointView.waypoint = nextWaypoint
            if User.currentUser!.route?.path.waypoints.first == nil {
                currentWayPointView.nextBtn.setTitle("Finish Route", for: .normal)
            } else {
                currentWayPointView.nextBtn.setTitle("Next Point", for: .normal)
            }
            currentWayPointView.configureView()
            currentView.removeFromSuperview()
            mainView.addSubview(currentView)
            
        } else {
            routeStarted = false
            currentView.removeFromSuperview()
            currentView = currentRouteView
            mainView.addSubview(currentView)
            
        }
        
    }
    
    func delete(type: String, index: Int) {
        //type- "Route" or "Waypoint"
        //TODO- delete the route or waypoint from firebase
        if (type == "Route") {
            //delete the Route
            User.currentUser!.routes.remove(at: index)
            //TODO
        } else {
            //delete the Waypoint
            User.currentUser!.routes.remove(at: index)
            //TODO
        }
    }
    
    func addNew(type: String, index: Int, tableView: UITableView) {
        //type- "Route" or "Waypoint"
        //TODO- a lot of the information is in dummy variables bc i don't know what to put there
        //popup with the information to edit
        let alertController = UIAlertController(title: "New \(type)", message: "Fill out the fields.", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            if (type == "Route") {
                //Route
                let nameString = (alertController.textFields![0] as UITextField).text
                let descString = (alertController.textFields![1] as UITextField).text
                let dateString = (alertController.textFields![2] as UITextField).text
                let user1String = (alertController.textFields![3] as UITextField).text
                let user2String = (alertController.textFields![4] as UITextField).text
                let time = "" //estimated time
                let miles = 0 // total miles
                let polyLine = ""
                let uid = ""
                let user1 = "" //based on user1TF
                let user2 = "" //based on user2TF
                User.currentUser!.routes.append(Route(path: Path(name: nameString!, desc: descString!, waypoints: [], miles: Double(miles), time: time, overviewPolyline: polyLine, uid: uid), user1: user1, user2: user2, user1Name: user1String!, user2Name: user2String!, date: NewDate.parse(dateStr: dateString!).timeIntervalSince1970))
                tableView.reloadData()
            } else {
                //Waypoint
                let addString = (alertController.textFields![0] as UITextField).text
                let phoneString = (alertController.textFields![1] as UITextField).text
                let latitude = 0
                let longitude = 0
                let priority = 0
                User.currentUser!.routes[index].path.waypoints.push(Waypoint(address: addString!, phoneNumber: phoneString!, info: "", title: addString!, latitude: Float(latitude), longitude: Float(longitude), priority: priority))
                tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        if (type == "Route") {
            //Route
            alertController.addTextField { (textField) in
                textField.placeholder = "Name"
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "Description"
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "Date (yyy-mm-dd)"
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "User 1"
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "User 2"
            }
        } else {
            //Waypoint
            alertController.addTextField { (textField) in
                textField.placeholder = "Address"
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "Phone Number"
            }
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true);

    }
}
