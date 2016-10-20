//
//  User.swift
//  MealsOnWheels
//
//  Created by Akhilesh Aji on 2/17/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON

class User: NSObject {
    static var email: String?
    static var uid: String?
    static var routes: Array<Route> = Array<Route>()
    static var route: Route?
    var ref = FIRDatabase.database().reference()
    
    override init() {
        super.init()
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                User.uid = user.uid
                User.email = user.email
                self.ref.child("users").child(User.uid!).child("paths").observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        let routes = snapshot.value as? NSArray
                        for (route) in routes! {
                            self.ref.child("paths").child(route as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                                User.routes.append(Route(dict: JSON(snapshot.value as? NSDictionary)))
                            })
                        }
                    }
//                    commented out section is used to manually poppulate testing data
                    
//                    MapTasks.getDirections("671 10th St NW, Atlanta, GA 30318", destination: "548 Northside Dr NW, Atlanta, GA 30318", waypointStrings: ["746 Marietta St NW, Atlanta, GA 30318", "539 10th St NW, Atlanta, GA 30318", "388 Luckie St NW, Atlanta, GA 30313"], travelMode: nil) { (str, success, route) in
//                        print(route?.toDict())
//                        self.ref.child(user.uid).child("paths").childByAutoId().setValue(route?.toDict())
//                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
            } else {
                User.uid = nil
                User.email = nil
                User.routes = Array<Route>()
            }
        }
    }

}
