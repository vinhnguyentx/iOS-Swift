//
//  User.swift
//  HopJocky
//
//  Created by Matt Union on 3/31/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import Foundation
import Firebase

class User{
    private var USER_REF: Firebase?
    private var Uid: String?
    
    private var Email = "Unknown"
    private var Password = "Unknown"
    private var Beercred = 0
    private var BarsVisited: Dictionary<String, Int> = [:]
    private var BeersHad: Dictionary<String, Double> = [:] //key: beer name Value: user rating
    private var EarnedBeerchievements: Dictionary<String,Int> = ["Newb": 0]
    private var ProfilePic = "Newb"
    private var Title = "Newb"
    
    var alertController:UIAlertController? = nil

    var uid: String{
        return self.Uid!
    }
    
    var email: String{
        return self.Email
    }
    
    var password: String{
        return self.Password
    }
    
    var beercred: Int{
        return self.Beercred
    }
    
    var earnedBeerchievements: Dictionary<String, Int>{
        return self.EarnedBeerchievements
    }
    
    var barsVisited: Dictionary<String, Int>{
        return self.BarsVisited
    }
    
    var beersHad: Dictionary<String, Double>{
        return self.BeersHad
    }
    
    var profilepic: String{
        return self.ProfilePic
    }
    
    var title: String{
        return self.Title
    }
    
    var userRef: Firebase?{
        return self.USER_REF
    }
    
    init(uid: String){
        self.Uid = uid
        self.USER_REF = Firebase(url: "\(BASE_URL)/users/\(self.Uid!)")
    }
    
    func changeProfilePic(picName: String){
        self.ProfilePic = picName
        push()
    }
    
    func addCred(earnedCred: Int){
        self.Beercred += earnedCred
        checkRank()
        push()
    }
    
    //updates your rank if you have enough beercred
    func checkRank(){
        if beercred >= 250{
            self.Title = "Rookie"
        }
        if beercred >= 500{
            self.Title = "Tippler"
        }
        if beercred >= 750{
            self.Title = "Ale Addict"
        }
        if beercred >= 1250{
            self.Title = "Hops Handler"
        }
        if beercred >= 1500{
            self.Title = "Hop Head"
        }
        if beercred >= 1750{
            self.Title = "Boozer"
        }
        if beercred >= 2000{
            self.Title = "Incorrigible Ale Hound"
        }
        if beercred >= 2250{
            self.Title = "Slops Surveyor"
        }
        if beercred >= 2500{
            self.Title = "Grog Artist"
        }
        if beercred >= 2750{
            self.Title = "Beer Buff"
        }
        if beercred >= 3000{
            self.Title = "Beer Devotee"
        }
        if beercred >= 3250{
            self.Title = "Beer Expert"
        }
        if beercred >= 3500{
            self.Title = "Beer Maven"
        }
        if beercred >= 3750{
            self.Title = "Beerologist"
        }
        if beercred >= 4000{
            self.Title = "Libationist"
        }
        if beercred >= 4250{
            self.Title = "Wert Guru"
        }
        if beercred >= 4500{
            self.Title = "The Chairman of the Brewed"
        }
        if beercred >= 4000{
            self.Title = "Brew Master"
        }
        if beercred >= 4250{
            self.Title = "HopJocky"
        }
    }
    
    func addBeer(beerName: String, rating: Double, viewController: AnyObject){
        if(BeersHad[beerName] == nil){
            if (BeersHad.isEmpty){
                addBeerchievement("I Remember My First Beer", viewController: viewController)
            }
            //if time is before 5, unlock beerchievement
            let currentDate = NSDate()
            if(currentDate.hour() < 17){
                addBeerchievement("5 O'clock Somewhere", viewController: viewController)
            }
            //every beer drank earns you 10 beercred
            addCred(10)
            BeersHad[beerName] = rating
            push()
        }
    }
    
    //check user into a bar
    func checkin(name: String, viewController: BarDetailViewController){
        var count = self.BarsVisited[name]
        if count == nil{
            count = 0
        }
        self.BarsVisited[name] = count! + 1
        //every bar checked into earns you 25 beercred
        addCred(25)
        checkForBeerchievement(name, viewController: viewController)
        push()
    }
    
    func addReview(barName: String, review: Dictionary<String, String>){
        
    }
    
    //check if user has met requirements for any Beerchievemnt
    func checkForBeerchievement(barName: String, viewController: AnyObject){
        for bar in barsVisited.keys{
            let BAR_REF = Firebase(url: "\(BASE_URL)/Bars/\(bar)")
            BAR_REF!.observeEventType(.Value, withBlock: { snapshot in
                let snap = snapshot.value
                
                if let barDictionary = snap as? Dictionary<String, AnyObject> {
                    if let checkGroup = barDictionary["Group"] as? String{
                        if checkGroup == "Dirty 6th"{
                            self.addBeerchievement("Gettin' Dirty", viewController: viewController)
                        }
                        if checkGroup == "Rainey"{
                            self.addBeerchievement("Rainey", viewController: viewController)
                        }
                        if checkGroup == "Drag"{
                            self.addBeerchievement("What a Drag", viewController: viewController)
                        }
                        if checkGroup == "Austin Brewery"{
                            self.addBeerchievement("The Local", viewController: viewController)
                        }
                    }
                }
            })
        }
        if barsVisited.count > 1 {
            self.addBeerchievement("Bar Hopper", viewController: viewController)
        }
        if barsVisited[barName] >= 10{
            self.addBeerchievement("The Regular", viewController: viewController)
        }
    }
    
    func addBeerchievement(name: String, viewController: AnyObject){
        let earnedBeerchievementsList = earnedBeerchievements.keys
        //if beerchievement hasn't been earned before then add it to earnedBeerchievements Dict
        if !earnedBeerchievementsList.contains(name) {
            EarnedBeerchievements[name] = earnedBeerchievements.count + 1
            //add reward for beerchievement
            let reward = allBeerchievements[name]?.reward
            addCred(reward!)
            push()
            let alert = UIAlertController(title: "Beerchievement Earned!", message: "You unlocked the '\(name)' Beerchievement! Check it out in the profile settings page.", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "Sweet! I'll check it out later", style: .Default, handler: nil)
            
            alert.addAction(action)
            
            viewController.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //update database with new user info
    func push(){
        self.USER_REF!.childByAppendingPath("Beercred").setValue(self.beercred)
        self.USER_REF!.childByAppendingPath("BarsVisited").setValue(self.barsVisited)
        self.USER_REF!.childByAppendingPath("Beerchievements").setValue(self.earnedBeerchievements)
        self.USER_REF!.childByAppendingPath("BeersHad").setValue(self.beersHad)
        self.USER_REF!.childByAppendingPath("ProfilePic").setValue(self.profilepic)
        self.USER_REF!.childByAppendingPath("Title").setValue(self.title)

    }
    
    //check database for new user info
    func pull(){
        self.USER_REF!.observeEventType(.Value, withBlock: {
            snapshot in
            let snap = snapshot.value
            
            if let userDictionary = snap as? Dictionary<String, AnyObject> {
                if let checkEmail = userDictionary["Email"] as? String{
                    self.Email = checkEmail
                }
                if let checkPassword = userDictionary["Password"] as? String{
                    self.Password = checkPassword
                }
                if let checkCred = userDictionary["Beercred"] as? Int{
                    self.Beercred = checkCred
                }
                if let checkBeerchievement = userDictionary["Beerchievements"] as? Dictionary<String, Int>{
                    self.EarnedBeerchievements = checkBeerchievement
                }
                if let checkIns = userDictionary["BarsVisited"] as? Dictionary<String, Int>{
                    self.BarsVisited = checkIns
                }
                if let checkBeersHad = userDictionary["BeersHad"] as? Dictionary<String, Double>{
                    self.BeersHad = checkBeersHad
                }
                if let pic = userDictionary["ProfilePic"] as? String{
                    self.ProfilePic = pic
                }
                if let rank = userDictionary["Title"] as? String{
                    self.Title = rank
                }
            }
        })
 
    }
}