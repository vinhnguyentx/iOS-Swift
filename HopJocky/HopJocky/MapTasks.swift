//
//  MapTasks.swift
//  HopJocky
//
//  Created by Vinh Nguyen on 4/4/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

class MapTasks: NSObject {
    
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
    var lookupAddressResults: Dictionary<NSObject, AnyObject>!
    var fetchedFormattedAddress: String!
    var fetchedAddressLongitude: Double!
    var fetchedAddressLatitude: Double!
    
    var title = ""
    
    
    override init() {
        super.init()
    }
    
    
    func geocodeAddress(rawAddress: String!, withCompletionHandler completionHandler: ((status: String, success: Bool) -> Void)) {
        let address: String! = removeSpecialCharsFromString(rawAddress)
        
        if let lookupAddress = address {
            var geocodeURLString = baseURLGeocode + "address=" + lookupAddress
            geocodeURLString = geocodeURLString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            
            let geocodeURL = NSURL(string: geocodeURLString)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let geocodingResultsData = NSData(contentsOfURL: geocodeURL!)
                
                do {
                    let BAR_REF = Firebase(url: (String)("\(BASE_URL)/Bars/\(address)"))
                    BAR_REF.observeEventType(.Value, withBlock: { snapshot in
                        let snap = snapshot.value
                        
                        if let barDictionary = snap as? Dictionary<NSObject, AnyObject>{
                            var lat = false
                            var lng = false
                            if let checklat = barDictionary["lat"] as? NSNumber{
                                self.fetchedAddressLatitude = checklat.doubleValue
                                lat = true
                            }
                            if let checklng = barDictionary["lng"] as? NSNumber{
                                self.fetchedAddressLongitude = checklng.doubleValue
                                lng = true
                            }
                            if lat == true && lng == true {
                                
                                self.title = snapshot.key
                                completionHandler(status: "OK", success: true)
                            }
                            //                            print("BAR_REF was correct, but didn't contain values for lat or lnd")
                        }
                        
                        }, withCancelBlock: { error in
                            print("no in HopJocky DataBase")
                    })
                    
                    //bar name typed into search bar wasn't in our database, so use google's
                    let dictionary: Dictionary<NSObject, AnyObject> = try NSJSONSerialization.JSONObjectWithData(geocodingResultsData!, options: NSJSONReadingOptions.MutableContainers) as! Dictionary<NSObject, AnyObject>
                    
                    let status = dictionary["status"] as! String
                    
                    if status == "OK" {
                        let allResults = dictionary["results"] as! Array<Dictionary<NSObject, AnyObject>>
                        self.lookupAddressResults = allResults[0]
                        
                        //                        self.fetchedFormattedAddress = self.lookupAddressResults["formatted_address"] as! String
                        self.title = self.lookupAddressResults["formatted_address"] as! String
                        let geometry = self.lookupAddressResults["geometry"] as! Dictionary<NSObject, AnyObject>
                        self.fetchedAddressLongitude = ((geometry["location"] as! Dictionary<NSObject, AnyObject>)["lng"] as! NSNumber).doubleValue
                        self.fetchedAddressLatitude = ((geometry["location"] as! Dictionary<NSObject, AnyObject>)["lat"] as! NSNumber).doubleValue
                        
                        completionHandler(status: status, success: true)
                    }
                    else {
                        completionHandler(status: status, success: false)
                    }
                    
                } catch let error as NSError {
                    print(error)
                    completionHandler(status: "", success: false)
                }
                
            })
        }
        else {
            completionHandler(status: "No valid address.", success: false)
        }
    }
    
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    
    
}