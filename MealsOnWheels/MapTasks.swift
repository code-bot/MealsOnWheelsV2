

//  MapTask.swift
//  MealsOnWheels
//
//  Created by Akhilesh on 12/17/15.
//  Copyright (c) 2015 Akhilesh. All rights reserved.


import Foundation
import GoogleMaps
import SwiftyJSON
import Firebase

class MapTasks : NSObject {
    static let baseURLGeocode = "https:maps.googleapis.com/maps/api/geocode/json?"
    static let baseURLDirections = "https:maps.googleapis.com/maps/api/directions/json?"
    static let ref = FIRDatabase.database().reference()
    
    override init() {
        super.init()
    }
    
    
    
    static func getDirections(_ origin: String!, destination: String!, waypointStrings: Array<String>!, travelMode: AnyObject!, completionHandler: @escaping ((_ status: String, _ success: Bool, _ route: Path?) -> Void)) {
        if let originLocation = origin {
            if let destinationLocation = destination {
                var directionsURLString = baseURLDirections + "origin=" + originLocation + "&destination=" + destinationLocation
                directionsURLString += "&waypoints=optimize:true"
                if waypointStrings.count > 0  {
                    for waypoint in waypointStrings {
                        directionsURLString += "|"+(waypoint)
                    }
                }

                directionsURLString = directionsURLString.addingPercentEscapes(using: String.Encoding.utf8)!
                let directionsURL = URL(string: directionsURLString)
                DispatchQueue.main.async(execute: {() -> Void in
                    let directionsData = try? Data(contentsOf: directionsURL!)
                    
                    do {
                        let json = JSON(data: directionsData!)
                        let status = json["status"].stringValue
                        if status == "OK" {
                            let selectedRoute = json["routes"].arrayValue[0]
                            let overviewPolyline = selectedRoute["overview_polyline"]
                            let legs = selectedRoute["legs"]
                            let order = selectedRoute["waypoint_order"].arrayObject as! Array<Int>
                            let pathPoly = overviewPolyline["points"].stringValue
                            var waypoints = Array<Waypoint>()
                            for (idx,leg) in legs {
                                let lastStep = leg["steps"].array?.last
                                let destinationJSON = lastStep?["end_location"]
                                let destinationLat = destinationJSON?["lat"].floatValue
                                let destinationLng = destinationJSON?["lng"].floatValue
                                var address = ""
                                if Int(idx)! < order.count {
                                    let indexOfA = order.index(of: Int(idx)!)
                                    address = waypointStrings[indexOfA!]
                                } else {
                                    address = destination
                                }
                                waypoints.append(Waypoint(address: address, phoneNumber: "", info: "", title: address, latitude: destinationLat!, longitude: destinationLng!, priority: Int(idx)!))
                            }
                            var totalDistanceInMeter = UInt(0)
                            var totalDurationInSeconds = UInt(0)
                            for (_, leg) in legs {
                                totalDistanceInMeter += UInt(leg["distance"]["value"].intValue)
                                totalDurationInSeconds += UInt(leg["duration"]["value"].intValue)
                            }
                            var distanceInMiles: Double = Double(totalDistanceInMeter)/1609.34
                            distanceInMiles = round(distanceInMiles * 100) / 100
                            let mins = totalDurationInSeconds/60
                            let hours = mins/60
                            let days = hours/24
                            let totalDuration = "Duration: \(days) days, \(hours%24) hr, \(mins%60) min"
                            let firPath = ref.child(User.uid!).child("paths").childByAutoId()
                            let key = firPath.key
                            let path = Path(name: "", desc: "", waypoints: waypoints, miles: distanceInMiles, time: totalDuration, overviewPolyline: pathPoly, uid: key)
                            firPath.setValue(path.toDict())
                            
                            
                            completionHandler(status, true, path)
                        } else {
                            completionHandler(status, false, nil)
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        completionHandler("", false, nil)
                    }
                })
                
            } else {
                completionHandler("Destination is nil.", false, nil)
            }
        } else {
            completionHandler("Origin is nil", false, nil)
        }
    }
    

}
