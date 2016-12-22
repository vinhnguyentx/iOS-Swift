//
//  SettingsViewController.swift
//  HopJocky
//
//  Created by Matt Union on 5/1/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SettingsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var BeerchievementCollectionView: UICollectionView!
    
    var alertController:UIAlertController? = nil
    let beerchievementKeys = Array(user.earnedBeerchievements.keys)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        BeerchievementCollectionView.delegate = self
        BeerchievementCollectionView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.earnedBeerchievements.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BeerchievementCollectionViewCell
        
        // Configure the cell
        let beerchievementID = self.beerchievementKeys[indexPath.row]
        let beerchievement = allBeerchievements[beerchievementID]
        cell.BeerchievementImage.image = beerchievement!.image
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let beerchievementID = self.beerchievementKeys[indexPath.row]
        let beerchievement = allBeerchievements[beerchievementID]
        
        self.alertController = UIAlertController(title: "\(beerchievement!.name)", message: "\(beerchievement!.howToUnlock)", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Make Profile Pic", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            user.changeProfilePic("\(beerchievement!.name)")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action:UIAlertAction) in
        }
        
        self.alertController!.addAction(okAction)
        self.alertController!.addAction(cancelAction)
        
        self.presentViewController(self.alertController!, animated: true, completion:nil)
    }
    
    @IBAction func ChangeBackgroundButton(sender: AnyObject) {
        self.alertController = UIAlertController(title: "Change Background", message: "By Default, text boxes are semi-transparent so you can still see the cool background picture. If you find that this makes it hard to read you can make the backgrounds solid white.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Make Background Solid White", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            let prefs = NSUserDefaults.standardUserDefaults()
            prefs.setValue("White", forKey: "Background")
        }
        let cancelAction = UIAlertAction(title: "Make Background Semi-transparent", style: UIAlertActionStyle.Cancel) { (action:UIAlertAction) in
            let prefs = NSUserDefaults.standardUserDefaults()
            prefs.setValue("Transparent", forKey: "Background")
        }
        
        self.alertController!.addAction(okAction)
        self.alertController!.addAction(cancelAction)
        
        self.presentViewController(self.alertController!, animated: true, completion:nil)
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
