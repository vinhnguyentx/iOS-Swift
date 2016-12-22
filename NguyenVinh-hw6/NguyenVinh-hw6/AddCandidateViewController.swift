//
//  AddCandidateViewController.swift
//  NguyenVinh-hw6
//
//  Created by Vinh Nguyen on 3/10/16.
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class AddCandidateViewController: UIViewController, DataModelProtocol, UITextFieldDelegate {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var segControlPartyOption: UISegmentedControl!
    
    @IBOutlet weak var respondLabel: UILabel!
    @IBAction func segControlPartyAction(sender: AnyObject) {
        
        switch self.segControlPartyOption.selectedSegmentIndex {
        case 0:
            self.party = "Democrat"
        case 1:
            self.party = "Republican"
        default:
            break
        }
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        
        if firstName.text == "" || lastName.text == "" || state.text == "" || party == "" {
            self.respondLabel!.text = "You have to fill in all information"
        } else {
            // changed in hw 6 - post notification
            // create a dictionary for passing values
            let dicNoti = ["firstName": firstName.text!, "lastName": lastName.text!, "state": state.text!, "party": party]
            NSNotificationCenter.defaultCenter().postNotificationName("addCandidateNotificationKey", object: nil, userInfo: dicNoti)
            
            // call addCandidateNotify function in main view
            rootView!.addCandidateNotify()
            
            // dismiss the keyboard
            self.view.endEditing(true)
        }
    }
    

    var rootView:ViewController? = nil
    private var party:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        party = "Democrat"
        self.navigationItem.title = "Add Candidate"
        
        self.firstName.delegate = self
        self.lastName.delegate = self
        self.state.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // dismiss the keyboard when touching anywhere
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    // dismiss the keyboard when touching the return key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func notify(message:String) {
        dispatch_async(dispatch_get_main_queue()) {
            let alertController = UIAlertController(title: "Save Data", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }

}
