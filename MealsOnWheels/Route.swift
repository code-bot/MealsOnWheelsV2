//
//  Route.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 10/6/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation
import SwiftPriorityQueue
import GoogleMaps

class Route {
    var name: String
    var description: String
    var waypoints = PriorityQueue<Waypoint>(ascending: true)
    var totalMiles: Double
    var estimatedTime: String
    var overviewPolyline: GMSPath

    init(name: String, desc: String, waypoints: [Waypoint], miles: Double, time: String, overviewPolyline: String) {
        self.name = name
        self.description = desc
        for waypoint in waypoints {
            self.waypoints.push(waypoint)
        }
        self.estimatedTime = time
        self.totalMiles = miles
        self.overviewPolyline = GMSPath(fromEncodedPath: overviewPolyline)!
    }
    
}
