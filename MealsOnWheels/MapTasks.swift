

//  MapTask.swift
//  MealsOnWheels
//
//  Created by Akhilesh on 12/17/15.
//  Copyright (c) 2015 Akhilesh. All rights reserved.


import Foundation
import GoogleMaps
import SwiftyJSON

class MapTasks : NSObject {
    static let baseURLGeocode = "https:maps.googleapis.com/maps/api/geocode/json?"
    
    static let baseURLDirections = "https:maps.googleapis.com/maps/api/directions/json?"
    
    override init() {
        super.init()
    }
    
    
    
    static func getDirections(_ origin: String!, destination: String!, waypointStrings: Array<String>!, travelMode: AnyObject!, completionHandler: @escaping ((_ status: String, _ success: Bool, _ route: Route?) -> Void)) {
        
//        
//        let htmlDestination = destination.addingPercentEscapes(using: String.Encoding.utf8)!
//        
//
//        let directionsRequest = "comgooglemaps-x-callback:" +
//        "?daddr=" + htmlDestination +
//        "&x-success=MOWapp:?resume=true&x-source=MOW"
//        let directionsURL = URL(string:directionsRequest);
//        if (UIApplication.shared.canOpenURL( URL(string: "comgooglemaps-x-callback:")!)) {
//            UIApplication.shared.openURL(directionsURL!)
//        } else {
//            print("Can't use comgooglemaps:");
//        }
//        if(customPath != nil) {
//            customPath.removeAllCoordinates()
//        }
//        if (UIApplication.shared.canOpenURL( URL(string: "comgooglemaps-x-callback:")!)) {
//            UIApplication.shared.openURL(directionsURL!)
//        } else {
//            print("Can't use comgooglemaps:");
//        }
//
        if let originLocation = origin {
            if let destinationLocation = destination {
                var directionsURLString = baseURLDirections + "origin=" + originLocation + "&destination=" + destinationLocation
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
                            let order = selectedRoute["waypoints_order"].arrayObject as! Array<Int>
                            let route = overviewPolyline["points"].stringValue
                            var waypoints = Array<Waypoint>()
                            for (idx,leg) in legs {
                                let lastStep = leg["steps"].array?.last
                                let destination = lastStep?["end_location"]
                                let destinationLat = destination?["lat"].floatValue
                                let destinationLng = destination?["lng"].floatValue
                                let address = waypointStrings[order[Int(idx)!]]
                                waypoints.append(Waypoint(address: address, phoneNumber: "", info: "", title: address, latitude: destinationLat!, longitude: destinationLng!, priority: order[Int(idx)!]))
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
                            completionHandler(status, true, Route(name: "", desc: "", waypoints: waypoints, miles: distanceInMiles, time: totalDuration, overviewPolyline: route))
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
