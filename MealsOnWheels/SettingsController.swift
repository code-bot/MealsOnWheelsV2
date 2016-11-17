//
//  SettingsController.swift
//  MealsOnWheels
//
//  Created by Sunwoo Yim on 11/17/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation
import UIKit
import SwiftLoader
import Firebase
import SwiftyJSON

class SettingsController: UIViewController, UITextFieldDelegate {
    
    var settingsView = SettingsView(frame: CGRect(x: 0, y: 0, width: MWConstants.screenWidth, height: MWConstants.screenHeight))
    
    func configureButtons() {
        settingsView.signoutBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func configureView() {
        configureButtons()
        self.view.addSubview(settingsView)
    }
    
    override func viewDidLoad() {
        configureView()
        configureButtons()
        self.dismissKeyboardAtTap()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        
    }
    
    func buttonAction(){
        //TODO- sign out
    }
}
