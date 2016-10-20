//
//  RegistrationProfileController.swift
//  MealsOnWheels
//
//  Created by Taabish Kathawala on 10/20/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation
import SwiftLoader
import UIKit
import Firebase

class RegistrationProfileController : UIViewController {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var photoimage: UIButton!
    @IBOutlet weak var signupbtn: UIButton!
    @IBOutlet weak var phoneNumberTF: UITextView!
    
    var registrationView = RegistrationProfileView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        
    }
    
    
    
}
