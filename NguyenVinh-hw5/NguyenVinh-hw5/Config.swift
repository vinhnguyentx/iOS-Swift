//
//  Config.swift
//  NguyenVinh-hw5
//
//  Created by Vinh Nguyen on 3/1/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import Foundation

class Config: NSObject {
    // Define keys for the values to store
    private static let kFirstName = ""
    private static let klastName = ""
    private static let kState = ""
    private static let kParty = ""
    
    
    class func setFirstName(name:String) {
        NSUserDefaults.standardUserDefaults().setObject(name, forKey: kFirstName)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func getFirstName() -> String {
        return NSUserDefaults.standardUserDefaults().objectForKey(kFirstName) as! String
    }
    
    class func setlastName(name:String) {
        NSUserDefaults.standardUserDefaults().setObject(name, forKey: klastName)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func getlastName() -> String {
        return NSUserDefaults.standardUserDefaults().objectForKey(klastName) as! String
    }
    
    class func setState(name:String) {
        NSUserDefaults.standardUserDefaults().setObject(name, forKey: kState)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func getState() -> String {
        return NSUserDefaults.standardUserDefaults().objectForKey(kState) as! String
    }
    class func setParty(name:String) {
        NSUserDefaults.standardUserDefaults().setObject(name, forKey: kParty)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func getParty() -> String {
        return NSUserDefaults.standardUserDefaults().objectForKey(kParty) as! String
    }
}