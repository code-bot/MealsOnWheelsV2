//
//  UIViewController+Extensions.swift
//  MealsOnWheels
//
//  Created by Rahul Ajmera on 10/20/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import UIKit

extension UIViewController{

    func dismissKeyboardAtTap(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }


}
