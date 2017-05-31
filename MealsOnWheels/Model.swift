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
    var blankRoute: Path
    
    init() {
        //Default data
        let waypoints = [Waypoint(address: "Address", phoneNumber: "Phone num", info: "info", title: "TITLE", latitude: 33.7490, longitude: -84.3880, priority: 0)]
        self.blankRoute = Path(name: "Route Name", desc: "Route desc", waypoints: waypoints, miles: 1, time: "a long while", overviewPolyline: "kjcmEndcbOgAdMKTCXQx@O`@U`@_@b@QNFNP\\RTd@\\PJJ[Vs@^}ARmAl@qGfAyLLcAVcATk@p@_Ap@m@`Ai@v@W@g@BqB@qH?mCFuAA}C?iG@oB@qADiC@_D?gCEa@oAAaCGDgB@eC@}B@Y?qAHSwAGUAT@vAFxAFzAH?pC?lAAbCF~BD`@?fCA~CAr@", uid: "UID")
        
    }
    
    static func getRoute() -> Path {
        let waypoints = [Waypoint(address: "Address", phoneNumber: "Phone num", info: "info", title: "TITLE", latitude: 33.7490, longitude: -84.3880, priority: 0)]
        let paths = [Path(name: "Route Name", desc: "Route desc", waypoints: waypoints, miles: 1, time: "a long while", overviewPolyline: "kjcmEndcbOgAdMKTCXQx@O`@U`@_@b@QNFNP\\RTd@\\PJJ[Vs@^}ARmAl@qGfAyLLcAVcATk@p@_Ap@m@`Ai@v@W@g@BqB@qH?mCFuAA}C?iG@oB@qADiC@_D?gCEa@oAAaCGDgB@eC@}B@Y?qAHSwAGUAT@vAFxAFzAH?pC?lAAbCF~BD`@?fCA~CAr@", uid: "UID")]
//        let blankRoute = Route(path: paths[0], user1: "User1", user2: "User2", user1Name: "User1", user2Name: "User2", date: 1476987788)
        return paths[0]
    }
}
