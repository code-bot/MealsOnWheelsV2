//
//  Route.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 10/6/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation
import SwiftPriorityQueue

class Route {
    var name: String
    var description: String
    var waypoints = PriorityQueue<Waypoint>(ascending: true)
    var totalMiles: Double
    var estimatedTime: String

    init(name: String, desc: String, waypoints: [Waypoint], miles: Double, time: String) {
        self.name = name
        self.description = desc
        for waypoint in waypoints {
            self.waypoints.push(waypoint)
        }
        self.estimatedTime = time
        self.totalMiles = miles
    }
    
}
