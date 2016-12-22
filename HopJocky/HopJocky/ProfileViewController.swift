//
//  ProfileViewController.swift
//  HopJocky
//
//  Created by Matt Union on 3/21/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var beercredLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailLabel.alpha = 0.85
        self.beercredLabel.alpha = 0.85
        self.titleLabel.alpha = 0.85
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.emailLabel.text = user?.email
        self.beercredLabel.text = String(user!.beercred)
        self.profilePic.image = allBeerchievements[user.profilepic]?.image
        self.titleLabel.text = user.title
        
        //check user preferences
        let prefs = NSUserDefaults.standardUserDefaults()
        if let backgroundPref = prefs.stringForKey("Background"){
            if backgroundPref == "White"{
                self.emailLabel.alpha = 1.0
                self.beercredLabel.alpha = 1.0
                self.titleLabel.alpha = 1.0
            }
            else{
                self.emailLabel.alpha = 0.85
                self.beercredLabel.alpha = 0.85
                self.titleLabel.alpha = 0.85
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
