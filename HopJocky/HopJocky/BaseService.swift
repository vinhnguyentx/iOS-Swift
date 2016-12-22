//
//  BaseService.swift
//  HopJocky
//
//  Created by Matt Union on 3/9/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import Foundation
import Firebase

let BASE_URL = "https://hopjocky.firebaseio.com"

let FIREBASE_REF = Firebase(url: BASE_URL)
let USERS_REF = Firebase(url: "\(BASE_URL)/users")
let BARS_REF = Firebase(url: "\(BASE_URL)/Bars")
let BEERS_REF = Firebase(url: "\(BASE_URL)/Beers")

//Macro for getting time
extension NSDate
{
    func hour() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
    
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let minute = components.minute
        
        //Return Minute
        return minute
    }
    
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let timeString = formatter.stringFromDate(self)
        
        //Return Short Time String
        return timeString
    }
}

//user object for global use
var user: User!
//a dict of all possible beerchievements
let beerchievements = Beerchievements()
let allBeerchievements = beerchievements.dict

var CURRENT_USER: Firebase{
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    
    let currentUser = Firebase(url: "\(FIREBASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
    
    return currentUser!
}

//update list of all beers in our database
func updateBeerList(){
    
}
