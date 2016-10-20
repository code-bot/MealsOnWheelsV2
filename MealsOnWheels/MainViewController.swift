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
    let currentView = CurrentRouteView(frame: CGRect(x: 0, y: MWConstants.navBarHeight + 20.0, width: MWConstants.screenWidth, height: MWConstants.screenHeight - MWConstants.tabBtnHeight - MWConstants.navBarHeight - 20.0))
    let myRoutesView = MyRoutesView(frame: CGRect(x: 0, y: MWConstants.navBarHeight + 20.0, width: MWConstants.screenWidth, height: MWConstants.screenHeight - MWConstants.tabBtnHeight - MWConstants.navBarHeight - 20.0))
    
    func configureButtons() {
        mainView.tabView.currentRoute.addTarget(self, action: #selector(switchPage(_:)), for: .touchUpInside)
        
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
        return Model.sharedInstance.routes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = myRoutesView.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let routes = Model.sharedInstance.routes[indexPath.row];
        cell.textLabel?.text = routes.path.name
        return cell
    }
}
