//
//  ReviewReaderViewController.swift
//  HopJocky
//
//  Created by Matt Union on 4/7/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit

class ReviewReaderViewController: UIViewController {
    @IBOutlet weak var AuthorLabel: UILabel!
    @IBOutlet weak var ReviewTextField: UITextView!
    @IBOutlet weak var StaticRating: UILabel!
    
    @IBOutlet weak var beer1Image: UIImageView!
    @IBOutlet weak var beer2Image: UIImageView!
    @IBOutlet weak var beer3Image: UIImageView!
    @IBOutlet weak var beer4Image: UIImageView!
    @IBOutlet weak var beer5Image: UIImageView!
    
    var author: String?
    var reviewText: String?
    var rating: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        AuthorLabel.text = self.author!
        ReviewTextField.text = self.reviewText!
        
        if rating != nil{
            loadRating(rating!)
        }
        else{
            loadRating(0.0)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //check user preferences
        let prefs = NSUserDefaults.standardUserDefaults()
        if let backgroundPref = prefs.stringForKey("Background"){
            if backgroundPref == "White"{
                self.AuthorLabel.alpha = 1.0
                self.ReviewTextField.alpha = 1.0
                self.StaticRating.alpha = 1.0
            }
            else{
                self.AuthorLabel.alpha = 0.85
                self.ReviewTextField.alpha = 0.85
                self.StaticRating.alpha = 0.85
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadRating(rating: Double){
        let images = [beer1Image, beer2Image, beer3Image, beer4Image, beer5Image]

        if(rating == 0.0){
            for index in 0...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating == 0.5){
            images[0].image = UIImage(named: "halfBeer")
            for index in 1...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating == 1.0){
            images[0].image = UIImage(named: "fullBeer")
            for index in 1...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating == 1.5){
            images[0].image = UIImage(named: "fullBeer")
            images[1].image = UIImage(named: "halfBeer")
            for index in 2...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating == 2.0){
            images[0].image = UIImage(named: "fullBeer")
            images[1].image = UIImage(named: "fullBeer")
            for index in 2...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating == 2.5){
            images[0].image = UIImage(named: "fullBeer")
            images[1].image = UIImage(named: "fullBeer")
            images[2].image = UIImage(named: "halfBeer")
            for index in 3...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating == 3.0){
            images[0].image = UIImage(named: "fullBeer")
            images[1].image = UIImage(named: "fullBeer")
            images[2].image = UIImage(named: "fullBeer")
            for index in 3...4{
                images[index].image = UIImage(named: "emptyBeer")
            }
        }
        else if(rating == 3.5){
            for index in 0...2{
                images[index].image = UIImage(named: "fullBeer")
            }
            images[3].image = UIImage(named: "halfBeer")
            images[4].image = UIImage(named: "emptyBeer")
        }
        else if(rating == 4.0){
            for index in 0...3{
                images[index].image = UIImage(named: "fullBeer")
            }
            images[4].image = UIImage(named: "emptyBeer")
        }
        else if(rating == 4.5){
            for index in 0...3{
                images[index].image = UIImage(named: "fullBeer")
            }
            images[4].image = UIImage(named: "halfBeer")
        }
        else if(rating == 5.0){
            for index in 0...4{
                images[index].image = UIImage(named: "fullBeer")
            }
        }
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
