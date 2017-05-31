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
    var email: String!
    var uid: String!
    var name: String!
    var routes: Array<Path> = Array<Path>()
    var route: Path?
    static var currentUser: User?
    static let ref = FIRDatabase.database().reference()

    

    
    init(email: String, uid: String, name: String) {
        super.init()
        self.email = email
        self.uid = uid
        self.name = name
        self.routes = Array<Path>()
    }
    
    
    static func setCurrentUser() {
        let user = FIRAuth.auth()?.currentUser
        User.currentUser = User(email: (user?.email!)!, uid: (user?.uid)!, name: "");
        getUsers()
    }
    
    static func loadRoutes(user: User) {
        User.ref.child("users").child(user.uid!).child("routes").observeSingleEvent(of: .value, with: { ( snapshot) in
            let response = JSON(snapshot.value as! NSDictionary)
            for route in response.array! {
                User.ref.child("routes").child(route.stringValue).observeSingleEvent(of: .value, with: { ( snapshot) in
                    User.currentUser!.routes.append(Path(dict: JSON(snapshot)))
                })
            }
        })
    }
    
    static func getUsers() {
        User.ref.child("users").observeSingleEvent(of: .value, with: {(snapshot) in
//            let response = JSON(snapshot.value as! NSDictionary)
            let dict = snapshot.value as! NSDictionary
            for key in dict {
                
            }
        })
    }
}

