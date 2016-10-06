//
//  Model.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 10/6/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation

class Model {
    
    static let sharedInstance = Model()
    var routes: [Route]
    
    init() {
        //Default data
        let waypoints = [Waypoint(address: "Address", phoneNumber: "Phone num", info: "info", title: "TITLE", streetImg: MWConstants.noImg!)]
        self.routes = [Route(name: "Route Name", desc: "Route desc", waypoints: waypoints)]
    }
}
