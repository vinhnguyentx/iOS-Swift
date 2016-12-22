//
//  ReviewWriterViewController.swift
//  HopJocky
//
//  Created by Matt Union on 4/6/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Firebase

class ReviewWriterViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var SummaryTextField: UITextField!
    @IBOutlet weak var FullReviewTextField: UITextView!
    @IBOutlet weak var StarLabel: UILabel!
    @IBOutlet weak var SliderOutlet: UISlider!
    @IBOutlet weak var StaticWriteShort: UILabel!
    @IBOutlet weak var StaticWrite: UILabel!
    
    
    var alertController:UIAlertController? = nil
    var rating = 2.5
    
    
    var barName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.SummaryTextField.delegate = self
        self.FullReviewTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        //check user preferences
        let prefs = NSUserDefaults.standardUserDefaults()
        if let backgroundPref = prefs.stringForKey("Background"){
            if backgroundPref == "White"{
                self.SummaryTextField.alpha = 1.0
                self.FullReviewTextField.alpha = 1.0
                self.StaticWriteShort.alpha = 1.0
                self.StaticWrite.alpha = 1.0
                self.StarLabel.alpha = 1.0
            }
            else{
                self.SummaryTextField.alpha = 0.85
                self.FullReviewTextField.alpha = 0.85
                self.StaticWriteShort.alpha = 0.85
                self.StaticWrite.alpha = 0.85
                self.StarLabel.alpha = 0.85
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.SummaryTextField.resignFirstResponder()
        return true
    }
    
//    func textViewShouldEndEditing(textView: UITextView) -> Bool {
//        self.FullReviewTextField.resignFirstResponder()
//        return true
//    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func SliderValueChange(sender: UISlider) {
        let sliderValue = Double(sender.value)
        if sliderValue >= 0 && sliderValue <= 0.25{
            self.rating = 0
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
        StarLabel.text = "Bar Rating: \(self.rating)"
    }
    
    @IBAction func PostButton(sender: AnyObject) {
        if SummaryTextField.text != "" && FullReviewTextField.text != ""{
            let reviewDict = ["Summary" : "\(SummaryTextField!.text!)", "Review" : "\(FullReviewTextField!.text!)", "Author" : "\(user.email)", "Rating" : self.rating]
            let BAR_REF = Firebase(url: "\(BASE_URL)/Bars/\(self.barName!)")
            let postsRef = BAR_REF.childByAppendingPath("Reviews")
            let postRef = postsRef.childByAutoId()
            postRef.setValue(reviewDict)
            self.navigationController?.popViewControllerAnimated(true)
        }
        else{
            self.alertController = UIAlertController(title: "Error", message: "all text fields must be filled to post a review", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "My Bad, I'll Fix That", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            }
            self.alertController!.addAction(okAction)
            self.presentViewController(self.alertController!, animated: true, completion:nil)
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
