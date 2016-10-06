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
        let waypoints = [Waypoint(address: "Address", phoneNumber: "Phone num", info: "info", title: "TITLE", latitude: 0.0, longitude: 0.0, priority: 0)]
        self.routes = [Route(name: "Route Name", desc: "Route desc", waypoints: waypoints, miles: 1, time: "a while")]
    }
}
