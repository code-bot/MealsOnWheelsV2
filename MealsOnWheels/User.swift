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
    var email: String?
    var uid: String?
    var routes: Array<Route> = Array<Route>()
    var route: Route?
    static var currentUser: User?
    static let ref = FIRDatabase.database().reference()

    

    
    init(email: String, uid: String) {
        super.init()
        self.email = email
        self.uid = uid
        self.routes = Array<Route>()
    }
    
    static func setCurrentUser() {
        let user = FIRAuth.auth()?.currentUser
        User.currentUser = User(email: (user?.email!)!, uid: (user?.uid)!);
    }
    
    static func loadCurrentRoutes() {
        User.ref.child("users").child(self.currentUser!.uid!).child("routes").observeSingleEvent(of: .value, with: { ( snapshot) in
            let response = JSON(snapshot.value as! NSDictionary)
            for route in response.array! {
                User.ref.child("routes").child(route.stringValue).observeSingleEvent(of: .value, with: { ( snapshot) in
                    User.currentUser!.routes.append(Route(dict: JSON(snapshot)))
                })
            }
        })
    }
}

