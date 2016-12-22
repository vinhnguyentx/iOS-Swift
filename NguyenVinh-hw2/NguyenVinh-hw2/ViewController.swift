//
//  ViewController.swift
//  NguyenVinh-hw2
//
//  Created by Vinh Nguyen on 2/4/16.
//  KeyboardDIsmiss using Prof. Seitsinger's provided code
//  Copyright © 2016 Vinh Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!   //create a text field for name input
    
    @IBOutlet weak var city: UITextField!   //create a text field for city input
    
    @IBOutlet weak var info: UILabel!       //create a label to display inputs

    //create save button to process and display input
    @IBAction func saveButton(sender: AnyObject) {
        
        let spaceSet = NSCharacterSet.whitespaceCharacterSet()
        
        //check if any of input fields is empty or has only white spaces
        if (name.text!.stringByTrimmingCharactersInSet(spaceSet) == "" || city.text!.stringByTrimmingCharactersInSet(spaceSet) == "") {
            
            info.text = "You must enter a value for *both* name and city!!"
            
        } else {
            
            info.text = "\(name.text!) - \(city.text!)"
            
        }
        
    }
    
    @IBOutlet var txtField:UITextField!   // create a textfield variable

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // UITextFieldDelegate delegate method
    //
    // This method is called when the user touches the Return key on the
    // keyboard. The 'textField' passed in is a pointer to the textField
    // widget the cursor was in at the time they touched the Return key on
    // the keyboard.
    //
    // From the Apple documentation: Asks the delegate if the text field
    // should process the pressing of the return button.
    //
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // A responder is an object that can respond to events and handle them.
        //
        // Resigning first responder here means this text field will no longer be the first
        // UI element to receive an event from this apps UI - you can think of it as giving
        // up input 'focus'.
        self.txtField.resignFirstResponder()
        
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    // This causes the keyboard to go away also - but handles all situations when
    // the user touches anywhere outside the keyboard.
    //
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }

}

