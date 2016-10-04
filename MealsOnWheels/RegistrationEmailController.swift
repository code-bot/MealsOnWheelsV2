//
//  RegistrationEmailController.swift
//  MealsOnWheels
//
//  Created by Taabish Kathawala on 9/15/16.
//  Copyright © 2016 Akhilesh. All rights reserved.
//

import Foundation
import SwiftLoader
import UIKit

class RegistrationEmailController : UIViewController {
    
    var passConfirm = false
    var registrationEmailView = RegistrationEmailView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        
    }
    
    func configureView() {
        configureButtons()
        self.view = registrationEmailView
    }
    
    
    override func viewDidLoad() {
        configureView()
    }
    
    
    
    
    
    
    
    
    
    
    
}
