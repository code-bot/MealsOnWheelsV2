//
//  Route.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 10/6/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation

class Route {
    var name: String
    var description: String
    var waypoints: [Waypoint]
    var totalMiles: Double
    
    init(name: String, desc: String, waypoints: [Waypoint], miles: Double) {
        self.name = name
        self.description = desc
        self.waypoints = waypoints
        self.totalMiles = miles
    }
    
}
