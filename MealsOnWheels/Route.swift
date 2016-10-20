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
import Firebase
var ref = FIRDatabase.database().reference()

class Route {
    var path: Path
    var user1: String
    var user2: String
    var date: NSDate
    
    init(path: Path, user1: String, user2: String, date: Double) {
        self.path = path
        self.user1 = user1
        self.user2 = user2
        self.date = NSDate(timeIntervalSince1970: date)
    }
    
//    init(dict: JSON) {
//        ref.child("paths").child(dict["path"].stringValue).observeSingleEvent(of: .value, with: { (snapshot) in
//            self.path = Path(dict: JSON(snapshot.value as? NSDictionary))
//        })
//        user1 = dict["user1"].stringValue
//        user2 = dict["user2"].stringValue
//        date = NSDate(timeIntervalSince1970: dict["date"].doubleValue)
//    }
    
    init(dict: JSON, path: JSON) {
        self.path = Path(dict: path)
        user1 = dict["user1"].stringValue
        user2 = dict["user2"].stringValue
        date = NSDate(timeIntervalSince1970: dict["date"].doubleValue)
    }
    
    func toDict() -> NSDictionary {
        let dict = NSMutableDictionary()
        dict["user1"] = user1
        dict["user2"] = user2
        dict["path"] = path.toDict()
        dict["date"] = date.timeIntervalSince1970
        return dict
    }
}
