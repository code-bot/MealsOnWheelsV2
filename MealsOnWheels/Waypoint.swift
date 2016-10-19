//
//  Waypoint.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 3/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import GoogleMaps
import SwiftyJSON


class Waypoint: Comparable {
    var address: String!
    var phoneNumber: String!
    var info: String!
    var title: String!
    var latitude: Float!
    var longitude: Float!
    var priority: Int!
    
    init(address: String, phoneNumber: String, info: String, title: String, latitude: Float, longitude: Float, priority: Int) {
        self.address = address
        self.info = info
        self.phoneNumber = phoneNumber
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.priority = priority
    }
    
    init(dict: JSON) {
        self.address = dict["address"].stringValue
        self.phoneNumber = dict["phoneNumber"].stringValue
        self.info = dict["info"].stringValue
        self.title = dict["title"].stringValue
        self.latitude = dict["latitude"].floatValue
        self.longitude = dict["longitude"].floatValue
        self.priority = dict["priority"].intValue
    }
    
    func toDict() -> NSDictionary {
        let dict = NSMutableDictionary()
        dict["address"] = address
        dict["phoneNumber"] = phoneNumber
        dict["info"] = info
        dict["title"] = title
        dict["latitude"] = latitude
        dict["longitude"] = longitude
        dict["priority"] = priority
        return dict
    }
    
    static func < (lhs: Waypoint, rhs: Waypoint) -> Bool {
        return lhs.priority < rhs.priority
    }
    
    static func == (lhs: Waypoint, rhs: Waypoint) -> Bool {
        return lhs.priority == rhs.priority
    }
}
