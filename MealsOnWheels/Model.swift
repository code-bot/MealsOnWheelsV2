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
        let paths = [Path(name: "Route Name", desc: "Route desc", waypoints: waypoints, miles: 1, time: "a long while", overviewPolyline: "kjcmEndcbOgAdMKTCXQx@O`@U`@_@b@QNFNP\\RTd@\\PJJ[Vs@^}ARmAl@qGfAyLLcAVcATk@p@_Ap@m@`Ai@v@W@g@BqB@qH?mCFuAA}C?iG@oB@qADiC@_D?gCEa@oAAaCGDgB@eC@}B@Y?qAHSwAGUAT@vAFxAFzAH?pC?lAAbCF~BD`@?fCA~CAr@", uid: "UID")]
        self.routes = [Route(path: paths[0], user1: "User1", user2: "User2", date: 1476987788)]
    }
}
