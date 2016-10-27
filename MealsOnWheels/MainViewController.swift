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

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mainView = MainView();
    let currentView = CurrentWaypointView(frame: CGRect(x: 0, y: MWConstants.navBarHeight + 20.0, width: MWConstants.screenWidth, height: MWConstants.screenHeight - MWConstants.tabBtnHeight - MWConstants.navBarHeight - 20.0))
    let myRoutesView = MyRoutesView(frame: CGRect(x: 0, y: MWConstants.navBarHeight + 20.0, width: MWConstants.screenWidth, height: MWConstants.screenHeight - MWConstants.tabBtnHeight - MWConstants.navBarHeight - 20.0))
    
    func configureButtons() {
        mainView.tabView.currentRoute.addTarget(self, action: #selector(switchPage(_:)), for: .touchUpInside)
        currentView.nextBtn.addTarget(self, action: #selector(nextLeg), for: .touchUpInside)
        mainView.tabView.myRoutes.addTarget(self, action: #selector(switchPage(_:)), for: .touchUpInside)
    }
    
    func configureView() {
        configureButtons()
        
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
    
    func switchPage(_ sender: UIButton) {
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
        return User.routes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = myRoutesView.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let route = User.routes[indexPath.row];
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let convertedDate = dateFormatter.string(from: route.date as Date)
        let cellText = "\(route.path.name)\t\(convertedDate)\nUsers: \(route.user1Name) & \(route.user2Name)"
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.text = cellText
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //switch to waypoints view
        let myWaypointsController = WaypointsController()
        myWaypointsController.route = User.routes[indexPath.row]
        myWaypointsController.myWaypointsView.tableView.delegate = myWaypointsController;
        myWaypointsController.myWaypointsView.tableView.dataSource = myWaypointsController;
        myWaypointsController.myWaypointsView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mainView.addSubview(myWaypointsController.myWaypointsView)
        myRoutesView.removeFromSuperview()
        //self.present(myWaypointsController, animated: true, completion: nil)
    }
    
    func nextLeg() {
        User.route?.path.nextLeg()
    }
}
