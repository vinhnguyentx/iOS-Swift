//
//  BeerDetailViewController.swift
//  HopJocky
//
//  Created by Matt Union on 3/22/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Firebase

class BeerDetailViewController: UIViewController {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ABVLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var StyleLabel: UILabel!
    @IBOutlet weak var BrewerLabel: UILabel!
    @IBOutlet weak var StarLabel: UILabel!
    @IBOutlet weak var SliderOutlet: UISlider!
    
    @IBOutlet weak var StaticBrewer: UILabel!
    @IBOutlet weak var StaticStyle: UILabel!
    @IBOutlet weak var StaticPrice: UILabel!
    @IBOutlet weak var StaticABV: UILabel!
    @IBOutlet weak var StaticRating: UILabel!
    
    
    @IBOutlet weak var beer1Image: UIImageView!
    @IBOutlet weak var beer2Image: UIImageView!
    @IBOutlet weak var beer3Image: UIImageView!
    @IBOutlet weak var beer4Image: UIImageView!
    @IBOutlet weak var beer5Image: UIImageView!
    
    var rating = 2.5
    var beerObj: Beer? = nil
    var barName: String?
    var totalRatings = 0.0
    var currAvgRating = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NameLabel.text = beerObj?.name
        StyleLabel.text = beerObj?.style
        
        if self.beerObj?.abv == -1{
            ABVLabel.text = "Unknown"
        }
        else{
            ABVLabel.text = String(beerObj!.abv) + "%"
        }
        
        if self.beerObj?.price == -1{
            PriceLabel.text = "Unknown"
        }
        else{
            PriceLabel.text = "$" + String(beerObj!.price)
        }
        BrewerLabel.text = beerObj?.brewer
    }
    
    override func viewWillAppear(animated: Bool) {
        //check user preferences
        let prefs = NSUserDefaults.standardUserDefaults()
        if let backgroundPref = prefs.stringForKey("Background"){
            if backgroundPref == "White"{
                self.NameLabel.alpha = 1.0
                self.ABVLabel.alpha = 1.0
                self.PriceLabel.alpha = 1.0
                self.BrewerLabel.alpha = 1.0
                self.StarLabel.alpha = 1.0
                self.StaticRating.alpha = 1.0
                self.StaticBrewer.alpha = 1.0
                self.StaticABV.alpha = 1.0
                self.StaticPrice.alpha = 1.0
                self.StaticStyle.alpha = 1.0
            }
            else{
                self.NameLabel.alpha = 0.85
                self.ABVLabel.alpha = 0.85
                self.PriceLabel.alpha = 0.85
                self.BrewerLabel.alpha = 0.85
                self.StarLabel.alpha = 0.85
                self.StaticRating.alpha = 0.85
                self.StaticBrewer.alpha = 0.85
                self.StaticABV.alpha = 0.85
                self.StaticPrice.alpha = 0.85
                self.StaticStyle.alpha = 0.85
            }
        }
        
        
        let BEER_REF = Firebase(url: "\(BASE_URL)/Beers/\(beerObj!.name)")
        BEER_REF!.observeEventType(.Value, withBlock: {
            snapshot in
            
            let snap = snapshot.value
            if let beerDictionary = snap as? Dictionary<String, AnyObject> {
                if let oldAvg = beerDictionary["AvgRating"] as? Double{
                    self.loadRating(oldAvg)
                    self.currAvgRating = oldAvg
                }
                else{
                    self.loadRating(0.0)
                    self.currAvgRating = 0.0
                }
                if let currCount = beerDictionary["TotalRatings"] as? Double{
                    self.totalRatings = currCount
                }
                else{
                    self.totalRatings = 0
                }
            }
            else{
                self.loadRating(0.0)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadRating(rating: Double){
        let images = [beer1Image, beer2Image, beer3Image, beer4Image, beer5Image]
        
        if(rating <= 0.25){
            for index in 0...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating >= 0.25 && rating <= 0.75){
            images[0].image = UIImage(named: "halfBeer")
            for index in 1...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating >= 0.75 && rating <= 1.25){
            images[0].image = UIImage(named: "fullBeer")
            for index in 1...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating >= 1.25 && rating <= 1.75){
            images[0].image = UIImage(named: "fullBeer")
            images[1].image = UIImage(named: "halfBeer")
            for index in 2...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating >= 1.75 && rating <= 2.25){
            images[0].image = UIImage(named: "fullBeer")
            images[1].image = UIImage(named: "fullBeer")
            for index in 2...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating >= 2.25 && rating <= 2.75){
            images[0].image = UIImage(named: "fullBeer")
            images[1].image = UIImage(named: "fullBeer")
            images[2].image = UIImage(named: "halfBeer")
            for index in 3...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating >= 2.75 && rating <= 3.25){
            images[0].image = UIImage(named: "fullBeer")
            images[1].image = UIImage(named: "fullBeer")
            images[2].image = UIImage(named: "fullBeer")
            for index in 3...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating <= 3.25 && rating <= 3.75){
            for index in 0...2{
                images[index].image = UIImage(named: "fullBeer")
            }
            images[3].image = UIImage(named: "halfBeer")
            images[4].image = UIImage(named: "emptyBeer")
        }
        else if(rating <= 3.75 && rating <= 4.25){
            for index in 0...3{
                images[index].image = UIImage(named: "fullBeer")
            }
            images[4].image = UIImage(named: "emptyBeer")
        }
        else if(rating <= 4.25 && rating <= 4.75){
            for index in 0...3{
                images[index].image = UIImage(named: "fullBeer")
            }
            images[4].image = UIImage(named: "halfBeer")
        }
        else if(rating <= 5.0){
            for index in 0...4{
                images[index].image = UIImage(named: "fullBeer")
            }
        }
    }
    
    @IBAction func SliderValueChange(sender: UISlider) {
        let sliderValue = Double(sender.value)
        if sliderValue >= 0.0 && sliderValue <= 0.25{
            self.rating = 0.0
        }
        else if sliderValue >= 0.25 && sliderValue <= 0.75{
            self.rating = 0.5
        }
        else if sliderValue >= 0.75 && sliderValue <= 1.25{
            self.rating = 1.0
        }
        else if sliderValue >= 1.25 && sliderValue <= 1.75{
            self.rating = 1.5
        }
        else if sliderValue >= 1.75 && sliderValue <= 2.25{
            self.rating = 2.0
        }
        else if sliderValue >= 2.25 && sliderValue <= 2.75{
            self.rating = 2.5
        }
        else if sliderValue >= 2.75 && sliderValue <= 3.25{
            self.rating = 3.0
        }
        else if sliderValue >= 3.25 && sliderValue <= 3.75{
            self.rating = 3.5
        }
        else if sliderValue >= 3.75 && sliderValue <= 4.25{
            self.rating = 4.0
        }
        else if sliderValue >= 4.25 && sliderValue <= 4.75{
            self.rating = 4.5
        }
        else if sliderValue >= 4.75 && sliderValue <= 5{
            self.rating = 5.0
        }
        StarLabel.text = "Your Beer Rating: \(self.rating)"
    }
    
    @IBAction func HadBeerButton(sender: AnyObject) {
        //add beer to user history
        user.addBeer((beerObj?.name)!, rating: self.rating, viewController: self)
        
        //add rating to rating average
        let userRating = self.rating
        let newTotalRatings = self.totalRatings + 1
        
        //        let weightedUserRating = userRating / Double(newTotalRatings)
        //        let weightedAvgRating = self.currAvgRating / Double(newTotalRatings)
        
        self.currAvgRating -= self.currAvgRating / Double(newTotalRatings)
        self.currAvgRating += userRating / Double(newTotalRatings)
        
        
        //        let newAvg = weightedAvgRating + weightedUserRating
        
        //push updates to database
        let BEER_REF = Firebase(url: "\(BASE_URL)/Beers/\(beerObj!.name)")
        let AVG_RATING_REF = BEER_REF.childByAppendingPath("AvgRating")
        AVG_RATING_REF.setValue(self.currAvgRating)
        let TOTAL_RATING_REF = BEER_REF.childByAppendingPath("TotalRatings")
        TOTAL_RATING_REF.setValue(totalRatings + 1)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
