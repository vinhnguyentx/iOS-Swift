//
//  Bar.swift
//  HopJocky
//
//  Created by Matt Union on 3/22/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import Foundation
import CoreLocation

class Bar{
    private var Name = ""
    private var Beers = Array<Beer>()
    private var HappyHour = ""
    private var Hours = ""
    private var Location = ""
    private var Lat = 0.0
    private var Lng = 0.0
    private var AvgRating = 0.0 //this is the average of all user ratings
    private var UsrRating = 0.0 //this is the rating given to the bar by current user
    private var DistanceFromUser = 0.0
    
    
    var name: String {
        return Name
    }
    
    var beerList: Array<Beer> {
        return Beers
    }
    
    var happyHour: String{
        return HappyHour
    }
    
    var hours: String {
        return Hours
    }
    
    var location: String {
        return Location
    }
    
    var lat: Double {
        return self.Lat
    }
    
    var lng: Double {
        return self.Lng
    }
    
    var avgRating: Double {
        return AvgRating
    }
    
    var usrRating: Double {
        return UsrRating
    }
    
    var distanceFromUsr: Double {
        return self.DistanceFromUser
    }
    
    //initilize bar
    init(key: String, dict: Dictionary<String, AnyObject>){
        self.Name = key
        
        if let barBeers = dict["Beers"] as? Array<Beer> {
            self.Beers = barBeers
        }
        
        if let barHappyHour = dict["Happy Hour"] as? String {
            self.HappyHour = barHappyHour
        }
        
        if let barHours = dict["Hours"] as? String {
            self.Hours = barHours
        }
        
        if let barLocation = dict["Location"] as? String {
            self.Location = barLocation
        }
        if let barLat = dict["lat"] as? Double {
            self.Lat = barLat
        }
        if let barLng = dict["lng"] as? Double {
            self.Lng = barLng
        }
        if let checkAvgRating = dict["AvgRating"] as? Double{
            self.AvgRating = checkAvgRating
        }
        if let checkUsrRating = dict["UsrRating"] as? Double{
            self.UsrRating = checkUsrRating
        }
    }
    
    func setDistanceFromUsr(){
        let distance:CLLocationDegrees = MapViewController().checkDistanceFromUser(self.lat, longitude: self.lng)
        self.DistanceFromUser = distance
    }
    
}