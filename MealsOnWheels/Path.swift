//
//  Path.swift
//  MealsOnWheels
//
//  Created by Sahaj Bhatt on 10/6/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation
import SwiftPriorityQueue
import GoogleMaps
import SwiftyJSON

class Path {
    var name: String
    var description: String
    var waypoints = PriorityQueue<Waypoint>(ascending: true)
    var totalMiles: Double
    var estimatedTime: String
    var overviewPolyline: String
    var currentWaypoint: Waypoint?
    var uid: String
    init(name: String, desc: String, waypoints: [Waypoint], miles: Double, time: String, overviewPolyline: String, uid: String) {
        self.name = name
        self.description = desc
        for waypoint in waypoints {
            self.waypoints.push(waypoint)
        }
        self.estimatedTime = time
        self.totalMiles = miles
        self.overviewPolyline = overviewPolyline
        self.uid = uid
    }
    
    init(dict: JSON) {
        name = dict["name"].stringValue
        description = dict["description"].stringValue
        totalMiles = dict["totalMiles"].doubleValue
        estimatedTime = dict["estimatedime"].stringValue
        overviewPolyline = dict["overviewPolyline"].stringValue
        waypoints = PriorityQueue<Waypoint>(ascending: true)
        for waypoint in dict["waypoints"].array! {
            waypoints.push(Waypoint(dict: waypoint))
        }
        uid = dict["uid"].stringValue
    }
    
    func toDict() -> NSDictionary {
        let dict = NSMutableDictionary()
        dict["name"] = name
        dict["description"] = description
        dict["totalMiles"] = totalMiles
        dict["estimatedTime"] = estimatedTime
        dict["overviewPolyline"] = overviewPolyline
        var temp = [NSDictionary]()
        for waypoint in waypoints {
            temp.append(waypoint.toDict())
        }
        dict["waypoints"] = temp
        dict["uid"] = uid
        return dict
    }
    
    func getPath() -> GMSPath {
        return GMSPath(fromEncodedPath: overviewPolyline)!
    }
    
    func nextLeg() -> Waypoint? {
        //self.currentWaypoint = waypoints.pop() as Waypoint!
        
        if currentWaypoint == nil {
            return nil
        }
        let htmlDestination = currentWaypoint?.address.addingPercentEscapes(using: String.Encoding.utf8)!
        let directionsRequest = "comgooglemaps-x-callback://" + "?daddr=" + htmlDestination! + "&x-success=MOWapp:?resume=true&x-source=MOW"
        let directionsURL = URL(string:directionsRequest);
        if (UIApplication.shared.canOpenURL( URL(string: "comgooglemaps-x-callback://")!)) {
            UIApplication.shared.openURL(directionsURL!)
            return currentWaypoint
        } else {
            print("Can't use comgooglemaps:");
        }
        return nil
    }
    
    func getCurrentWaypoint() -> Waypoint? {
        self.currentWaypoint = waypoints.pop() as Waypoint!
        return currentWaypoint
    }
    
    func skipLeg() {
        var maxWeight = 0;
        for i in waypoints {
            if i.priority > maxWeight {
                maxWeight = i.priority;
            }
        }
        let end = waypoints.pop()
        end?.priority = maxWeight + 1;
        waypoints.push(end!);
    }
}
