//
//  SkiAreaData.swift
//  NguyenVinh-hw7
//
//  Created by Vinh Nguyen on 3/28/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class SkiAreaData: NSObject {
    
    var delegate: SkiAreaDataProtocol? = nil
    
    var message = "No nearby ski facilities"
    
    func getData(zipcode: String) {
        // build url
        let urlPathBase = "http://api.worldweatheronline.com/free/v2/ski.ashx?key=fc371a731202b57b2edc7a687df17&format=json"
        let urlIncludeLocationPrefix = "&includelocation=yes"
        let urlZipcodePrefix = "&q="
        var urlPath = urlPathBase + urlIncludeLocationPrefix
        urlPath = urlPath + urlZipcodePrefix + zipcode
        
        // request
        let url:NSURL? = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.responseError(self.message)
                }
            } else {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    if jsonResult != nil {
                        let json = JSON(jsonResult!)
                        if json["data", "error"] != nil {
                            // if the request return the data that contains error message
                            dispatch_async(dispatch_get_main_queue()) {
                                self.delegate?.responseError(self.message)
                            }
                        } else {
                            // get data from response
                            var data = [String: String]()
                            if let nearestArea = json["data", "nearest_area", 0, "areaName", 0, "value"].string {
                                data["area"] = nearestArea
                            }
                            if let country = json["data", "nearest_area", 0, "country", 0, "value"].string {
                                data["country"] = country
                            }
                            if let region = json["data", "nearest_area", 0, "region", 0, "value"].string {
                                data["region"] = region
                            }
                            // display data
                            dispatch_async(dispatch_get_main_queue()) {
                                self.delegate?.responseDataHandler(data)
                            }
                        }
                    }
                } catch {
                    // problem when fetching data
                    dispatch_async(dispatch_get_main_queue()) {
                        self.delegate?.responseError("Problem with fetching data")
                    }
                    print(data)
                }
            }
        }
        task.resume()
    }
}
