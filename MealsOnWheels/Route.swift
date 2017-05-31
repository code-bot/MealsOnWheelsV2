////
////  Route.swift
////  MealsOnWheels
////
////  Created by Sahaj Bhatt on 10/6/16.
////  Copyright © 2016 Sahaj Bhatt. All rights reserved.
////
//
//import Foundation
//import SwiftPriorityQueue
//import GoogleMaps
//import SwiftyJSON
//import Firebase
//var ref = FIRDatabase.database().reference()
//
//class Route {
//    var path: Path
//    //user's backend ID
//    var user1: String
//    var user2: String
//    //user's actual name
//    var user1Name: String
//    var user2Name: String
//    var date: NSDate
//    
//    init(path: Path, user1: String, user2: String, user1Name: String, user2Name: String, date: Double) {
//        self.path = path
//        self.user1 = user1
//        self.user2 = user2
//        self.user1Name = user1Name
//        self.user2Name = user2Name
//        self.date = NSDate(timeIntervalSince1970: date)
//    }
//    
//    init(dict: JSON) {
//        path = Path(dict: dict["path"])
//        user1 = dict["user1"].stringValue
//        user2 = dict["user2"].stringValue
//        user1Name = dict["user1Name"].stringValue
//        user2Name = dict["user2Name"].stringValue
//        date = NSDate(timeIntervalSince1970: dict["date"].doubleValue)
//    }
//    
//    func toDict() -> NSDictionary {
//        let dict = NSMutableDictionary()
//        dict["user1"] = user1
//        dict["user2"] = user2
//        dict["user1Name"] = user1Name
//        dict["user2Name"] = user2Name
//        dict["path"] = path.toDict()
//        dict["date"] = date.timeIntervalSince1970
//        return dict
//    }
//}
