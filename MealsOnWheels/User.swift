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
    var ref = FIRDatabase.database().reference()
    
    override init() {
        super.init()
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                User.uid = user.uid
                User.email = user.email
                self.ref.child(User.uid!).child("paths").observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        
                        print((snapshot.value as? NSDictionary)?.allKeys)
                        let routes = snapshot.value as? NSDictionary
                        for (_, route) in routes! {
                            User.routes.append(Route(dict: JSON(route)))
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
