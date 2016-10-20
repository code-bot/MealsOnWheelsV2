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
    var path: Path
    var user1: String
    var user2: String
    var date: String
    
    init(path: Path, user1: String, user2: String, date: String) {
        self.path = path
        self.user1 = user1
        self.user2 = user2
        self.date = date
    }
}
