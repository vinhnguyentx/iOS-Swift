//
//  BarDetailViewController.swift
//  HopJocky
//
//  Created by Matt Union on 3/22/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class BarDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var HappyHourLabel: UILabel!
    @IBOutlet weak var HoursLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var ReviewTableView: UITableView!
    @IBOutlet weak var StaticHappyHourLabel: UILabel!
    
    
    var barObj: Bar? = nil
    var reviews = [Review]()
    var reviewText:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NameLabel.text = barObj?.name
        HappyHourLabel.text = barObj?.happyHour
        HoursLabel.text = barObj?.hours
        LocationLabel.text = barObj?.location
        
        ReviewTableView.delegate = self
        ReviewTableView.dataSource = self
        
        let REVIEW_REF = Firebase(url: "\(BASE_URL)/Bars/\(barObj!.name)/Reviews")
        REVIEW_REF.observeEventType(.Value, withBlock: { snapshot in
            self.reviews = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots{
                    //make our bars array for tableview
                    if let reviewDict = snap.value as? Dictionary<String, AnyObject>{
                        let name = reviewDict["Author"] as! String
                        let short = reviewDict["Summary"] as! String
                        let long = reviewDict["Review"] as! String
                        let score = reviewDict["Rating"] as! Double
                        let review = Review(author: name, summary: short, review: long, rating: score)
                        
                        //insert new bar object into bar array
                        self.reviews.insert(review, atIndex: 0)
                    }
                }
            }
            //be sure that the tableView updates when there is new data
            self.ReviewTableView.reloadData()
            
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        //check user preferences
        let prefs = NSUserDefaults.standardUserDefaults()
        if let backgroundPref = prefs.stringForKey("Background"){
            if backgroundPref == "White"{
                self.NameLabel.alpha = 1.0
                self.HappyHourLabel.alpha = 1.0
                self.StaticHappyHourLabel.alpha = 1.0
                self.HoursLabel.alpha = 1.0
                self.LocationLabel.alpha = 1.0
                self.HoursLabel.alpha = 1.0
            }
            else{
                self.NameLabel.alpha = 0.85
                self.HappyHourLabel.alpha = 0.85
                self.StaticHappyHourLabel.alpha = 0.85
                self.HoursLabel.alpha = 0.85
                self.LocationLabel.alpha = 0.85
                self.HoursLabel.alpha = 0.85
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func CheckInButton(sender: AnyObject) {
        let distance:CLLocationDegrees = MapViewController().checkDistanceFromUser(barObj!.lat, longitude: barObj!.lng)
        
        if(distance > 50) {
            self.showAlertWithMessage("You are not close enough to the bar.")
        }
        else if(distance == -1) {
            self.showAlertWithMessage("Location settings are not enabled. Please enable them in the settings menu.")
        }
        else {
            self.showAlertWithMessage("You are checked in! Don't forget to leave a review.")
            user.checkin(barObj!.name, viewController: self)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellid", forIndexPath: indexPath)
        
        // Configure the cell...
        let review = reviews[indexPath.row]
        cell.textLabel?.text = review.summary
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ToMenuSegue"{
            let MenuTableView = segue.destinationViewController as! MenuTableViewController
            MenuTableView.barName = self.barObj?.name
        }
        else if segue.identifier == "ToReviewWriterSegue"{
            let reviewWriterViewController = segue.destinationViewController as! ReviewWriterViewController
            reviewWriterViewController.barName = self.barObj?.name
        }
        else if segue.identifier == "ToReviewReaderSegue"{
            let reviewReaderViewController = segue.destinationViewController as! ReviewReaderViewController
            let indexPath = self.ReviewTableView.indexPathForSelectedRow
            reviewReaderViewController.reviewText = self.reviews[indexPath!.row].review
            reviewReaderViewController.rating = self.reviews[indexPath!.row].rating
            reviewReaderViewController.author = self.reviews[indexPath!.row].author
        }
    }
    
    func showAlertWithMessage(message: String) {
        let alertController = UIAlertController(title: "HopJocky", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        alertController.addAction(closeAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }

}
