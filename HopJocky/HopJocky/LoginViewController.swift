//
//  LoginViewController.swift
//  HopJocky
//
//  Created by Matt Union on 3/9/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logoutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && CURRENT_USER.authData != nil{
            self.logoutButton.hidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func loginAction(sender: AnyObject) {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if email != "" && password != ""{
            FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                if error == nil{
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    self.logoutButton.hidden = false
                    
                    //create Global User Object
                    user = User(uid: authData.uid)
                    //update all data fields in user object with database info
                    user!.pull()
                                        
                    //wait to get user info before showing profile view controller
                    let seconds = 1.0
                    let delay = seconds * Double(NSEC_PER_SEC) //nanoseconds per seconds
                    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    
                    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                        //give tabVC storyboard
                        let myTabBar = self.storyboard?.instantiateViewControllerWithIdentifier("TabVC") as! UITabBarController
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        
                        appDelegate.window?.rootViewController = myTabBar
                    })
                }
                else{
                    //print(error)
                    let alert = UIAlertController(title: "Error", message: "Email and password doesn't match any users in our database. Please tap the 'Create Account' button to create an account if you don't have one", preferredStyle: .Alert)
                    
                    let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    
                    alert.addAction(action)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Enter email and password.", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(action)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }

    @IBAction func logoutAction(sender: AnyObject) {
        CURRENT_USER.unauth()
        
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        self.logoutButton.hidden = true
    }
}
