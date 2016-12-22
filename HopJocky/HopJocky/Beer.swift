//
//  Beer.swift
//  HopJocky
//
//  Created by Matt Union on 3/22/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import Foundation

class Beer{
    private var Key = "Unknown"
    private var Name = "Unknown"
    private var Style = "Unknown"
    private var Brewer = "Unknown"
    private var Price = 0 //make this a double before final build
    private var ABV = 0 //make this a double before final build
    private var AvgRating = 0.0 //this is the average of all user ratings
    private var TotalRatings = 0.0 //this is the number of reveiws a beer has recieved
    private var UsrRating = 0.0 //this is the rating given to the beer by current user
    private var Bars: Dictionary<String, Int> = [:] //list of bars that serve this beer

    
    var name: String {
        return Name
    }
    
    var abv: Int {
        return ABV
    }
    
    var price: Int{
        return Price
    }
    
    var style: String {
        return Style
    }
    
    var avgRating: Double {
        return AvgRating
    }
    
    var totalRatings: Double {
        return AvgRating
    }
    
    var usrRating: Double {
        return UsrRating
    }
    
    var brewer: String {
        return Brewer
    }
    var barsSold: Dictionary<String, Int> {
        return Bars
    }

    //initilize beer
    init(key: String, dict: Dictionary<String, AnyObject>){
        self.Key = key
        
        if let beerName = dict["Name"] as? String {
            self.Name = beerName
        }
        if let beerABV = dict["ABV"] as? Int {
            self.ABV = beerABV
        }
        if let beerPrice = dict["Price"] as? Int {
            self.Price = beerPrice
        }
        if let beerStyle = dict["Style"] as? String {
            self.Style = beerStyle
        }
        if let checkAvgRating = dict["AvgRating"] as? Double{
            self.AvgRating = checkAvgRating
        }
        if let checkTotalRatings = dict["TotalRatings"] as? Double{
            self.TotalRatings = checkTotalRatings
        }
        if let checkUsrRating = dict["UsrRating"] as? Double{
            self.UsrRating = checkUsrRating
        }
        if let checkBrewer = dict["Brewer"] as? String{
            self.Brewer = checkBrewer
        }
        if let checkBarSold = dict["BarsSold"] as? Dictionary<String, Int>{
            self.Bars = checkBarSold
        }
    }
    
    func setUsrRating(usrRating: Double){
        self.UsrRating = usrRating
    }

}