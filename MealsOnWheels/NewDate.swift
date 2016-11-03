//
//  NewDate.swift
//  MealsOnWheels
//
//  Created by Sunwoo Yim on 11/3/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation
class NewDate {

class func from(year:Int, month:Int, day:Int) -> NSDate {
    let c = NSDateComponents()
    c.year = year
    c.month = month
    c.day = day
    
    let gregorian = NSCalendar(identifier:NSCalendar.Identifier.gregorian)
    let date = gregorian!.date(from: c as DateComponents)
    return date! as NSDate
}

class func parse(dateStr:String, format:String="yyyy-MM-dd") -> NSDate {
    let dateFmt = DateFormatter()
    dateFmt.timeZone = NSTimeZone.default
    dateFmt.dateFormat = format
    return dateFmt.date(from: dateStr)! as NSDate
}
}
