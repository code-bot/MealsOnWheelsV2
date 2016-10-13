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
import SwiftyJSON

class Route {
    var name: String
    var description: String
    var waypoints = PriorityQueue<Waypoint>(ascending: true)
    var totalMiles: Double
    var estimatedTime: String
    var overviewPolyline: String
    var currentWaypoint: Waypoint?
    init(name: String, desc: String, waypoints: [Waypoint], miles: Double, time: String, overviewPolyline: String) {
        self.name = name
        self.description = desc
        for waypoint in waypoints {
            self.waypoints.push(waypoint)
        }
        self.estimatedTime = time
        self.totalMiles = miles
        self.overviewPolyline = overviewPolyline
    }
    
    init(dict: JSON) {
        name = dict["name"].stringValue
        description = dict["description"].stringValue
        totalMiles = dict["totalMiles"].doubleValue
        estimatedTime = dict["estimatedime"].stringValue
        overviewPolyline = dict["overviewPolyline"].stringValue
        for waypoint in dict["waypoints"] {
            
        }
        
    }
    
    func getPath() -> GMSPath {
        return GMSPath(fromEncodedPath: overviewPolyline)!
    }
    
    func nextLeg() {
        self.currentWaypoint = waypoints.pop() as Waypoint!
        let htmlDestination = currentWaypoint?.address.addingPercentEscapes(using: String.Encoding.utf8)!
        let directionsRequest = "comgooglemaps-x-callback:" + "?daddr=" + htmlDestination! + "&x-success=MOWapp:?resume=true&x-source=MOW"
        let directionsURL = URL(string:directionsRequest);
        if (UIApplication.shared.canOpenURL( URL(string: "comgooglemaps-x-callback:")!)) {
            UIApplication.shared.openURL(directionsURL!)
        } else {
            print("Can't use comgooglemaps:");
        }
    }
    
    func toDict() -> NSDictionary {
        let dict = NSMutableDictionary()
        dict["name"] = name
        dict["description"] = description
        dict["totalMiles"] = totalMiles
        dict["estimatedTime"] = estimatedTime
        dict["overviewPolyline"] = overviewPolyline
        var temp = [Waypoint]()
        for waypoint in waypoints {
            temp.append(waypoint)
        }
        dict["waypoints"] = temp
        return dict
    }
    
    
    
}
