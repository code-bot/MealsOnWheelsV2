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
        currentWayPointView.nextBtn.addTarget(self, action: #selector(nextWaypoint), for: .touchUpInside)
        currentWayPointView.showDirBtn.addTarget(self, action: #selector(showDirections), for: .touchUpInside)
        currentWayPointView.phoneNumBtn.addTarget(self, action: #selector(callPhoneNum), for: .touchUpInside)
        
        mainView.tabView.myRoutes.addTarget(self, action: #selector(switchPage(_:)), for: .touchUpInside)
        
        mainView.navBar.leftBtn.addTarget(self, action: #selector(navBtnAction), for: .touchUpInside)
        mainView.navBar.rightBtn.addTarget(self, action: #selector(navBtnAction), for: .touchUpInside)
    }
    
    func configureView() {        
        myWaypointsController.selectedIndex = -1
        myWaypointsController.mainViewController = self
        myWaypointsController.myWaypointsView.tableView.delegate = myWaypointsController;
        myWaypointsController.myWaypointsView.tableView.dataSource = myWaypointsController;
        myWaypointsController.myWaypointsView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myWaypointsController.myWaypointsView.startRouteButton.setTitle("Start Route", for:UIControlState.normal)
        myWaypointsController.myWaypointsView.startRouteButton.backgroundColor = UIColor.clear
        //myWaypointsController.myWaypointsView.startRouteButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        myWaypointsController.myWaypointsView.startRouteButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15.0)
        myWaypointsController.myWaypointsView.startRouteButton.addTarget(myWaypointsController, action: #selector(myWaypointsController.startRoute), for: UIControlEvents.touchUpInside)
        currentWayPointView.waypointTitleLbl.font = UIFont(name: "Avenir-Medium", size: 15.0)
        
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
    
    func navBtnAction(sender:UIButton) {
        if (sender.currentTitle == "Back") {
            backPage(sender: sender)
        } else if (sender.currentTitle == "Sign Out") {
            do {
                try FIRAuth.auth()?.signOut()
                present(LoginController(), animated: true, completion: nil)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            
            
            
            //Implement Backend Sign Out Here
            //Possibly add alert asking to confirm if user wants to sign out.
        }
    }
    
    func startRoute() {
        routeStarted = true
        currentView = currentWayPointView
        User.currentUser?.route?.initWaypointQueue()
        nextWaypoint()
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
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = DateFormatter.Style.medium
//        let convertedDate = dateFormatter.string(from: route.date as Date)
        let cellText = "\(route.name)"
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
            let alertController = UIAlertController(title: "Edit Route", message: route.name, preferredStyle: .alert)
            let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
//                let user1TF = alertController.textFields![0] as UITextField
//                let user2TF = alertController.textFields![1] as UITextField
//                User.currentUser!.routes[indexPath.row].user1Name = user1TF.text!
//                User.currentUser!.routes[indexPath.row].user2Name = user2TF.text!
                tableView.reloadData()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "User 1"
//                textField.text = User.currentUser!.routes[indexPath.row].user1Name
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "User 2"
//                textField.text = User.currentUser!.routes[indexPath.row].user2Name
            }
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true);
            tableView.setEditing(false, animated: true)
        })
        
        //delete
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Delete" , handler: { (action:UITableViewRowAction!, indexPath:IndexPath!) -> Void in
            //delete this cell
            self.delete(type: "Route", index: indexPath.row);
            tableView.setEditing(false, animated: true)
        })
        return [deleteAction, editAction]
    }
    
//    func skipLeg() {
//        User.currentUser?.route?.path.skipLeg()
//        if let nextWaypoint = User.currentUser?.route?.path.nextLeg() {
//            currentWayPointView.currWaypoint = nextWaypoint
//            if User.currentUser?.route?.path.waypoints.first == nil {
//                currentWayPointView.nextBtn.setTitle("Finish Route", for: .normal)
//            } else {
//                currentWayPointView.nextBtn.setTitle("Next Point", for: .normal)
//            }
//            currentWayPointView.configureView()
//            currentView.removeFromSuperview()
//            mainView.addSubview(currentView)
//            
//        } else {
//            routeStarted = false
//            currentView.removeFromSuperview()
//            currentView = currentRouteView
//            mainView.addSubview(currentView)
//        }
//    }
    
    func nextWaypoint() {

        if let nextWaypoint = User.currentUser!.route?.getCurrentWaypoint() {
            currentWayPointView.currWaypoint = nextWaypoint
            if User.currentUser!.route?.waypoints.first == nil {
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
    
    func showDirections() {
        User.currentUser!.route?.nextLeg()
    }
    
    func callPhoneNum() {
        let phoneNum = currentWayPointView.currWaypoint?.phoneNumber
        if let url = NSURL(string: "tel://\(phoneNum)"), UIApplication.shared.canOpenURL(url as URL){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            //UIApplication.shared.openURL(url as URL)
        } else {
            print("Can't open url to call")
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
//                let dateString = (alertController.textFields![2] as UITextField).text
//                let user1String = (alertController.textFields![3] as UITextField).text
//                let user2String = (alertController.textFields![4] as UITextField).text
                let time = "" //estimated time
                let miles = 0 // total miles
                let polyLine = ""
                let uid = ""
//                let user1 = "" //based on user1TF
//                let user2 = "" //based on user2TF
                User.currentUser!.routes.append(Path(name: nameString!, desc: descString!, waypoints: [], miles: Double(miles), time: time, overviewPolyline: polyLine, uid: uid))
                tableView.reloadData()
            } else {
                //Waypoint
                let addString = (alertController.textFields![0] as UITextField).text
                let phoneString = (alertController.textFields![1] as UITextField).text
                let latitude = 0
                let longitude = 0
                let priority = 0
                User.currentUser!.routes[index].waypoints.append(Waypoint(address: addString!, phoneNumber: phoneString!, info: "", title: addString!, latitude: Float(latitude), longitude: Float(longitude), priority: priority))
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
