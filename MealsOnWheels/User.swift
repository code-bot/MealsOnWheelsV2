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
    
    override init() {
        super.init()
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                User.uid = user.uid
                User.email = user.email
            } else {
                User.uid = nil
                User.email = nil
                User.routes = Array<Route>()
            }
        }
    }

}
